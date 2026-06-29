# Src/main.c 最近 20 次提交详细 diff

本文件提取了最近 20 次影响 [Src/main.c](Src/main.c) 的提交，并按时间顺序整理为完整 patch。

## 55f6c9206fe6 - 平顺电子刹车=GD32F103RCT6 ./build.sh

- Author: nn9kjmgp47-boop <nn9kjmgp47@privaterelay.appleid.com>
- Date: 2026-06-28
- Diff:

```diff
commit 55f6c9206fe680d505972abf4eca960caa911591
Author: nn9kjmgp47-boop <nn9kjmgp47@privaterelay.appleid.com>
Date: 2026-06-28
Subject: 平顺电子刹车=GD32F103RCT6 ./build.sh



diff --git a/Src/main.c b/Src/main.c
index 25f2950..9667096 100644
--- a/Src/main.c
+++ b/Src/main.c
@@ -121,40 +121,41 @@ static uint8_t sideboard_leds_R;
 
   static uint8_t  checkRemote = 0;
   static uint16_t distance;
   static float    steering;
   static int      distanceErr;  
   static int      lastDistance = 0;
   static uint16_t transpotter_counter = 0;
 #endif
 
 static int16_t    speed;                // local variable for speed. -1000 to 1000
 #ifndef VARIANT_TRANSPOTTER
   static int16_t  steer;                // local variable for steering. -1000 to 1000
   static int16_t  steerRateFixdt;       // local fixed-point variable for steering rate limiter
   static int16_t  speedRateFixdt;       // local fixed-point variable for speed rate limiter
   static int32_t  steerFixdt;           // local fixed-point variable for steering low-pass filter
   static int32_t  speedFixdt;           // local fixed-point variable for speed low-pass filter
 #endif
 
 static uint32_t    buzzerTimer_prev = 0;
 static uint32_t    inactivity_timeout_counter;
+static int16_t     filteredBrakeCmd = 0;
 static MultipleTap MultipleTapBrake;    // define multiple tap functionality for the Brake pedal
 
 static uint16_t rate = RATE; // Adjustable rate to support multiple drive modes on startup
 
 #ifdef MULTI_MODE_DRIVE
   static uint8_t drive_mode;
   static uint16_t max_speed;
 #endif
 
 
 int main(void) {
 
   HAL_Init();
   __HAL_RCC_AFIO_CLK_ENABLE();
   HAL_NVIC_SetPriorityGrouping(NVIC_PRIORITYGROUP_4);
   /* System interrupt init*/
   /* MemoryManagement_IRQn interrupt configuration */
   HAL_NVIC_SetPriority(MemoryManagement_IRQn, 0, 0);
   /* BusFault_IRQn interrupt configuration */
   HAL_NVIC_SetPriority(BusFault_IRQn, 0, 0);
@@ -304,52 +305,79 @@ int main(void) {
           throttleRate = THROTTLE_RELEASE_RATE;
         }
         rateLimiter16(input2[inIdx].cmd, throttleRate, &speedRateFixdt);
       }
 
       filtLowPass32(steerRateFixdt >> 4, FILTER, &steerFixdt);
       filtLowPass32(speedRateFixdt >> 4, FILTER, &speedFixdt);
       steer = (int16_t)(steerFixdt >> 16);  // convert fixed-point to integer
       speed = (int16_t)(speedFixdt >> 16);  // convert fixed-point to integer
 
       // ####### VARIANT_HOVERCAR #######
       #ifdef VARIANT_HOVERCAR
       if (inIdx == CONTROL_ADC) {               // Only use use implementation below if pedals are in use (ADC input)
 
         #ifdef MULTI_MODE_DRIVE
         if (speed >= max_speed) {
           speed = max_speed;
         }
         #endif
 
-        if (ABS(input1[inIdx].cmd) > 30) {                           // Brake active: generate a real opposing command proportional to pedal force.
-          int16_t brakeMagnitude = (int16_t)CLAMP((ABS(input1[inIdx].cmd) * 1000) / 1000, 0, 1000);
+        if (ABS(input1[inIdx].cmd) > 30) {                           // Smooth brake: ramp the request first, then scale by speed and deadband the zero-speed zone.
+          int16_t brakePedal = ABS(input1[inIdx].cmd);
+          int32_t brakeError = (int32_t)brakePedal - filteredBrakeCmd;
+          if (brakeError > BRAKE_RAMP_STEP) {
+            filteredBrakeCmd += BRAKE_RAMP_STEP;
+          } else if (brakeError < -BRAKE_RAMP_STEP) {
+            filteredBrakeCmd -= BRAKE_RAMP_STEP;
+          } else {
+            filteredBrakeCmd = brakePedal;
+          }
+
+          int32_t speedFactor = 1000;
+          if (speedAvgAbs < BRAKE_MIN_SPEED_RPM) {
+            speedFactor = 0;
+          } else if (speedAvgAbs < BRAKE_SMOOTH_ZONE_RPM) {
+            speedFactor = ((int32_t)speedAvgAbs - BRAKE_MIN_SPEED_RPM) * 1000 /
+                          (BRAKE_SMOOTH_ZONE_RPM - BRAKE_MIN_SPEED_RPM);
+          }
+
+          int16_t brakeMagnitude = (int16_t)((filteredBrakeCmd * speedFactor) / 1000);
+          brakeMagnitude = (int16_t)CLAMP(brakeMagnitude, 0, BRAKE_MAX_LIMIT);
+
           if (MultipleTapBrake.b_multipleTap && speedAvgAbs < 60) {
             speed = -(int16_t)CLAMP(brakeMagnitude, 0, REVERSE_SPEED_LIMIT);
           } else if (speedAvg > 0) {
             speed = -brakeMagnitude;
           } else if (speedAvg < 0) {
             speed =  brakeMagnitude;
           } else {
             speed = 0;
           }
         } else {
+          if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
+            filteredBrakeCmd -= BRAKE_RAMP_STEP;
+          } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
+            filteredBrakeCmd += BRAKE_RAMP_STEP;
+          } else {
+            filteredBrakeCmd = 0;
+          }
           speed = steer + speed;                      // Forward driving: in this case steer = Brake, speed = Throttle
         }
         steer = 0;                              // Do not apply steering to avoid side effects if STEER_COEFFICIENT is NOT 0
       }
       #endif
 
       #if defined(TANK_STEERING) && !defined(VARIANT_HOVERCAR) && !defined(VARIANT_SKATEBOARD) 
         // Tank steering (no mixing)
         cmdL = steer; 
         cmdR = speed;
       #else 
         // ####### MIXER #######
         mixerFcn(speed << 4, steer << 4, &cmdR, &cmdL);   // This function implements the equations above
       #endif
 
 
       // ####### SET OUTPUTS (if the target change is less than +/- 100) #######
       #ifdef INVERT_R_DIRECTION
         pwmr = cmdR;
       #else
```

## 47a0a0f62666 - 尝试fix全速油门时偶发抖动，平顺电子刹车=GD32F103RCT6 ./build.sh

- Author: nn9kjmgp47-boop <nn9kjmgp47@privaterelay.appleid.com>
- Date: 2026-06-28
- Diff:

```diff
commit 47a0a0f626660ca6bcfdd931c60255a60d73a9f6
Author: nn9kjmgp47-boop <nn9kjmgp47@privaterelay.appleid.com>
Date: 2026-06-28
Subject: 尝试fix全速油门时偶发抖动，平顺电子刹车=GD32F103RCT6 ./build.sh



diff --git a/Src/main.c b/Src/main.c
index 9667096..cb0e306 100644
--- a/Src/main.c
+++ b/Src/main.c
@@ -253,133 +253,139 @@ int main(void) {
         uint16_t speedBlend;                                        // Calculate speed Blend, a number between [0, 1] in fixdt(0,16,15)
         speedBlend = (uint16_t)(((CLAMP(speedAvgAbs,10,60) - 10) << 15) / 50); // speedBlend [0,1] is within [10 rpm, 60rpm]
       #endif
 
       #ifdef STANDSTILL_HOLD_ENABLE
         standstillHold();                                           // Apply Standstill Hold functionality. Only available and makes sense for VOLTAGE or TORQUE Mode
       #endif
 
       #ifdef VARIANT_HOVERCAR
       if (inIdx == CONTROL_ADC) {                                   // Only use use implementation below if pedals are in use (ADC input)
         if (speedAvgAbs < 60) {                                     // Check if Hovercar is physically close to standstill to enable Double tap detection on Brake pedal for Reverse functionality
           multipleTapDet(input1[inIdx].cmd, HAL_GetTick(), &MultipleTapBrake); // Brake pedal in this case is "input1" variable
         }
 
         if (input1[inIdx].cmd > 30) {                               // Brake pedal pressed: deactivate cruise control while braking
           cruiseControl((uint8_t)rtP_Left.b_cruiseCtrlEna);         // Cruise control deactivated by Brake pedal if it was active
         }
       }
       #endif
 
-      #ifdef ELECTRIC_BRAKE_ENABLE
-        electricBrake(speedBlend, 0);  // Apply Electric Brake without any reverse-mode interaction
+      #if defined(ELECTRIC_BRAKE_ENABLE) && !defined(VARIANT_HOVERCAR)
+        electricBrake(speedBlend, 0);  // Apply electric brake only for non-hovercar variants.
       #endif
 
       #ifdef VARIANT_HOVERCAR
-      if (inIdx == CONTROL_ADC) {                                   // Keep the brake pedal command directly tied to pedal force so it can generate real opposing torque.
-        if (speedAvg > 0) {
-          input1[inIdx].cmd = (int16_t)(-ABS(input1[inIdx].cmd));
-        } else if (speedAvg < 0) {
-          input1[inIdx].cmd = (int16_t)( ABS(input1[inIdx].cmd));
+      if (inIdx == CONTROL_ADC) {                                   // Convert brake pedal input into a smooth, direction-aware speed target before filtering.
+        int16_t throttleCommand = input2[inIdx].cmd;
+        int16_t brakePedalRaw = ABS(input1[inIdx].cmd);
+        int16_t brakeTarget = 0;
+
+        if (brakePedalRaw > BRAKE_PEDAL_THRESHOLD) {
+          int32_t speedFactor = 1000;
+          if (speedAvgAbs < BRAKE_MIN_SPEED_RPM) {
+            speedFactor = 0;
+          } else if (speedAvgAbs < BRAKE_SMOOTH_ZONE_RPM) {
+            speedFactor = ((int32_t)speedAvgAbs - BRAKE_MIN_SPEED_RPM) * 1000 /
+                          (BRAKE_SMOOTH_ZONE_RPM - BRAKE_MIN_SPEED_RPM);
+          }
+
+          int16_t brakeMagnitude = (int16_t)((brakePedalRaw * speedFactor) / 1000);
+          brakeMagnitude = (int16_t)CLAMP(brakeMagnitude, 0, BRAKE_MAX_LIMIT);
+
+          if (MultipleTapBrake.b_multipleTap && speedAvgAbs < 60) {
+            brakeTarget = -(int16_t)CLAMP(brakeMagnitude, 0, REVERSE_SPEED_LIMIT);
+          } else if (speedAvg > 0) {
+            brakeTarget = -brakeMagnitude;
+          } else if (speedAvg < 0) {
+            brakeTarget =  brakeMagnitude;
+          }
+        }
+
+        if (brakeTarget != 0) {
+          int32_t brakeError = (int32_t)brakeTarget - filteredBrakeCmd;
+          if (brakeError > BRAKE_RAMP_STEP) {
+            filteredBrakeCmd += BRAKE_RAMP_STEP;
+          } else if (brakeError < -BRAKE_RAMP_STEP) {
+            filteredBrakeCmd -= BRAKE_RAMP_STEP;
+          } else {
+            filteredBrakeCmd = brakeTarget;
+          }
+          throttleCommand = filteredBrakeCmd;
         } else {
-          input1[inIdx].cmd = 0;
+          if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
+            filteredBrakeCmd -= BRAKE_RAMP_STEP;
+          } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
+            filteredBrakeCmd += BRAKE_RAMP_STEP;
+          } else {
+            filteredBrakeCmd = 0;
+          }
+          throttleCommand = input2[inIdx].cmd;
         }
+
+        input1[inIdx].cmd = 0;
+        input2[inIdx].cmd = throttleCommand;
       }
       #endif
 
       #ifdef VARIANT_SKATEBOARD
         if (input2[inIdx].cmd < 0) {                                // When Throttle is negative, it acts as brake. This condition is to make sure it goes to 0 as we reach standstill (to avoid Reverse driving) 
           if (speedAvg > 0) {                                       // Make sure the braking is opposite to the direction of motion
             input2[inIdx].cmd  = (int16_t)(( input2[inIdx].cmd * speedBlend) >> 15);
           } else {
             input2[inIdx].cmd  = (int16_t)((-input2[inIdx].cmd * speedBlend) >> 15);
           }
         }
       #endif
 
       // ####### LOW-PASS FILTER #######
       rateLimiter16(input1[inIdx].cmd, rate, &steerRateFixdt);
 
       {
         int16_t throttleRate = THROTTLE_ACCEL_RATE;
-        if ((input2[inIdx].cmd << 4) < speedRateFixdt) {
+        int16_t throttleCommand = input2[inIdx].cmd;
+        #ifdef VARIANT_HOVERCAR
+        if (inIdx == CONTROL_ADC) {
+          throttleCommand = input2[inIdx].cmd;
+        }
+        #endif
+        if ((throttleCommand << 4) < speedRateFixdt) {
           throttleRate = THROTTLE_RELEASE_RATE;
         }
-        rateLimiter16(input2[inIdx].cmd, throttleRate, &speedRateFixdt);
+        rateLimiter16(throttleCommand, throttleRate, &speedRateFixdt);
       }
 
       filtLowPass32(steerRateFixdt >> 4, FILTER, &steerFixdt);
       filtLowPass32(speedRateFixdt >> 4, FILTER, &speedFixdt);
       steer = (int16_t)(steerFixdt >> 16);  // convert fixed-point to integer
       speed = (int16_t)(speedFixdt >> 16);  // convert fixed-point to integer
 
       // ####### VARIANT_HOVERCAR #######
       #ifdef VARIANT_HOVERCAR
       if (inIdx == CONTROL_ADC) {               // Only use use implementation below if pedals are in use (ADC input)
 
         #ifdef MULTI_MODE_DRIVE
         if (speed >= max_speed) {
           speed = max_speed;
         }
         #endif
 
-        if (ABS(input1[inIdx].cmd) > 30) {                           // Smooth brake: ramp the request first, then scale by speed and deadband the zero-speed zone.
-          int16_t brakePedal = ABS(input1[inIdx].cmd);
-          int32_t brakeError = (int32_t)brakePedal - filteredBrakeCmd;
-          if (brakeError > BRAKE_RAMP_STEP) {
-            filteredBrakeCmd += BRAKE_RAMP_STEP;
-          } else if (brakeError < -BRAKE_RAMP_STEP) {
-            filteredBrakeCmd -= BRAKE_RAMP_STEP;
-          } else {
-            filteredBrakeCmd = brakePedal;
-          }
-
-          int32_t speedFactor = 1000;
-          if (speedAvgAbs < BRAKE_MIN_SPEED_RPM) {
-            speedFactor = 0;
-          } else if (speedAvgAbs < BRAKE_SMOOTH_ZONE_RPM) {
-            speedFactor = ((int32_t)speedAvgAbs - BRAKE_MIN_SPEED_RPM) * 1000 /
-                          (BRAKE_SMOOTH_ZONE_RPM - BRAKE_MIN_SPEED_RPM);
-          }
-
-          int16_t brakeMagnitude = (int16_t)((filteredBrakeCmd * speedFactor) / 1000);
-          brakeMagnitude = (int16_t)CLAMP(brakeMagnitude, 0, BRAKE_MAX_LIMIT);
-
-          if (MultipleTapBrake.b_multipleTap && speedAvgAbs < 60) {
-            speed = -(int16_t)CLAMP(brakeMagnitude, 0, REVERSE_SPEED_LIMIT);
-          } else if (speedAvg > 0) {
-            speed = -brakeMagnitude;
-          } else if (speedAvg < 0) {
-            speed =  brakeMagnitude;
-          } else {
-            speed = 0;
-          }
-        } else {
-          if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
-            filteredBrakeCmd -= BRAKE_RAMP_STEP;
-          } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
-            filteredBrakeCmd += BRAKE_RAMP_STEP;
-          } else {
-            filteredBrakeCmd = 0;
-          }
-          speed = steer + speed;                      // Forward driving: in this case steer = Brake, speed = Throttle
-        }
         steer = 0;                              // Do not apply steering to avoid side effects if STEER_COEFFICIENT is NOT 0
       }
       #endif
 
       #if defined(TANK_STEERING) && !defined(VARIANT_HOVERCAR) && !defined(VARIANT_SKATEBOARD) 
         // Tank steering (no mixing)
         cmdL = steer; 
         cmdR = speed;
       #else 
         // ####### MIXER #######
         mixerFcn(speed << 4, steer << 4, &cmdR, &cmdL);   // This function implements the equations above
       #endif
 
 
       // ####### SET OUTPUTS (if the target change is less than +/- 100) #######
       #ifdef INVERT_R_DIRECTION
         pwmr = cmdR;
       #else
         pwmr = -cmdR;
       #endif
```

## c99322b32652 - 油门 /刹车/ 倒车策略说明=GD32F103RCT6

- Author: nn9kjmgp47-boop <nn9kjmgp47@privaterelay.appleid.com>
- Date: 2026-06-29
- Diff:

```diff
commit c99322b32652b75e59edb524ff3ebea37cb48a58
Author: nn9kjmgp47-boop <nn9kjmgp47@privaterelay.appleid.com>
Date: 2026-06-29
Subject: 油门 /刹车/ 倒车策略说明=GD32F103RCT6



diff --git a/Src/main.c b/Src/main.c
index cb0e306..7be3458 100644
--- a/Src/main.c
+++ b/Src/main.c
@@ -257,47 +257,54 @@ int main(void) {
       #ifdef STANDSTILL_HOLD_ENABLE
         standstillHold();                                           // Apply Standstill Hold functionality. Only available and makes sense for VOLTAGE or TORQUE Mode
       #endif
 
       #ifdef VARIANT_HOVERCAR
       if (inIdx == CONTROL_ADC) {                                   // Only use use implementation below if pedals are in use (ADC input)
         if (speedAvgAbs < 60) {                                     // Check if Hovercar is physically close to standstill to enable Double tap detection on Brake pedal for Reverse functionality
           multipleTapDet(input1[inIdx].cmd, HAL_GetTick(), &MultipleTapBrake); // Brake pedal in this case is "input1" variable
         }
 
         if (input1[inIdx].cmd > 30) {                               // Brake pedal pressed: deactivate cruise control while braking
           cruiseControl((uint8_t)rtP_Left.b_cruiseCtrlEna);         // Cruise control deactivated by Brake pedal if it was active
         }
       }
       #endif
 
       #if defined(ELECTRIC_BRAKE_ENABLE) && !defined(VARIANT_HOVERCAR)
         electricBrake(speedBlend, 0);  // Apply electric brake only for non-hovercar variants.
       #endif
 
+      int16_t throttleCommand = input2[inIdx].cmd;
+      int16_t brakePedalRaw = 0;
+      int16_t brakeTarget = 0;
+      int16_t brakeActive = 0;
+      int16_t reverseRequested = 0;
+      int16_t motionDir = (speedAvg > 0) ? 1 : ((speedAvg < 0) ? -1 : 0);
+
       #ifdef VARIANT_HOVERCAR
       if (inIdx == CONTROL_ADC) {                                   // Convert brake pedal input into a smooth, direction-aware speed target before filtering.
-        int16_t throttleCommand = input2[inIdx].cmd;
-        int16_t brakePedalRaw = ABS(input1[inIdx].cmd);
-        int16_t brakeTarget = 0;
+        brakePedalRaw = ABS(input1[inIdx].cmd);
+        brakeActive = (brakePedalRaw > BRAKE_PEDAL_THRESHOLD);
+        reverseRequested = (MultipleTapBrake.b_multipleTap && speedAvgAbs < 60) ? 1 : 0;
 
-        if (brakePedalRaw > BRAKE_PEDAL_THRESHOLD) {
+        if (brakeActive) {
           int32_t speedFactor = 1000;
           if (speedAvgAbs < BRAKE_MIN_SPEED_RPM) {
             speedFactor = 0;
           } else if (speedAvgAbs < BRAKE_SMOOTH_ZONE_RPM) {
             speedFactor = ((int32_t)speedAvgAbs - BRAKE_MIN_SPEED_RPM) * 1000 /
                           (BRAKE_SMOOTH_ZONE_RPM - BRAKE_MIN_SPEED_RPM);
           }
 
           int16_t brakeMagnitude = (int16_t)((brakePedalRaw * speedFactor) / 1000);
           brakeMagnitude = (int16_t)CLAMP(brakeMagnitude, 0, BRAKE_MAX_LIMIT);
 
           if (MultipleTapBrake.b_multipleTap && speedAvgAbs < 60) {
             brakeTarget = -(int16_t)CLAMP(brakeMagnitude, 0, REVERSE_SPEED_LIMIT);
           } else if (speedAvg > 0) {
             brakeTarget = -brakeMagnitude;
           } else if (speedAvg < 0) {
             brakeTarget =  brakeMagnitude;
           }
         }
 
@@ -566,52 +573,59 @@ if (now - lastSendTick >= 1000U) {
             #define MAX_RX_BYTES_TO_PRINT 12
             uint32_t max_bytes = (rx_len > MAX_RX_BYTES_TO_PRINT) ? MAX_RX_BYTES_TO_PRINT : rx_len; 
             for (uint32_t i = 0; i < max_bytes; i++) {
                 p += snprintf(rx_hex_str + p, sizeof(rx_hex_str) - p, "%02X ", rx_data[i]);
             }
             if (rx_len > MAX_RX_BYTES_TO_PRINT) {
                 snprintf(rx_hex_str + p - 1, sizeof(rx_hex_str) - p + 1, "..");
             }
         } else {
             snprintf(rx_hex_str, sizeof(rx_hex_str), "");
         }
 
         char err_detail[24] = {0};
         if (g_ctrlErrDetail_Left != 0U || g_ctrlErrDetail_Right != 0U) {
             snprintf(err_detail, sizeof(err_detail), " errL:%02X errR:%02X",
                      (unsigned int)g_ctrlErrDetail_Left,
                      (unsigned int)g_ctrlErrDetail_Right);
         }
 
         int written = snprintf(buf, sizeof(buf),
-                               "%lums L:%d R:%d TX2:%d RX2:%d fs:%d st:%d cL:%d cR:%d V:%d T:%d%s [%s]\r\n",
+                               "%lums L:%d R:%d TX2:%d RX2:%d fs:%d st:%d cL:%d cR:%d V:%d T:%d rev:%d tap:%d dir:%d br:%d bt:%d fbc:%d thr:%d%s [%s]\r\n",
                                (unsigned long)now,
                                (int)Feedback.speedL_meas, 
                                (int)Feedback.speedR_meas, 
                                (int)adc_buffer.l_tx2,
                                (int)adc_buffer.l_rx2,
                                (int)speed,
                                (int)steer,
                                (int)cmdL,
                                (int)cmdR,
                                (int)Feedback.batVoltage, 
                                (int)Feedback.boardTemp,
+                               (int)reverseRequested,
+                               (int)MultipleTapBrake.b_multipleTap,
+                               (int)motionDir,
+                               (int)brakePedalRaw,
+                               (int)brakeTarget,
+                               (int)filteredBrakeCmd,
+                               (int)throttleCommand,
                                err_detail,
                                rx_hex_str);
 
         // 5. 安全触发 DMA 发送
         if (written > 0 && written < sizeof(buf)) {
             HAL_UART_Transmit_DMA(&huart3, (uint8_t *)buf, written);
         }
         
         lastSendTick = now;
     }
 }
             
            }
         #endif
       }
     #endif
 
     // ####### POWEROFF BY POWER-BUTTON #######
     poweroffPressCheck();
```

## 0e02bb548d8f - 油门 /刹车/ 倒车策略说明=GD32F103RCT6

- Author: nn9kjmgp47-boop <nn9kjmgp47@privaterelay.appleid.com>
- Date: 2026-06-29
- Diff:

```diff
commit 0e02bb548d8f988b0d17ef32a9749188b817b4d1
Author: nn9kjmgp47-boop <nn9kjmgp47@privaterelay.appleid.com>
Date: 2026-06-29
Subject: 油门 /刹车/ 倒车策略说明=GD32F103RCT6



diff --git a/Src/main.c b/Src/main.c
index 7be3458..876cff2 100644
--- a/Src/main.c
+++ b/Src/main.c
@@ -270,112 +270,109 @@ int main(void) {
       }
       #endif
 
       #if defined(ELECTRIC_BRAKE_ENABLE) && !defined(VARIANT_HOVERCAR)
         electricBrake(speedBlend, 0);  // Apply electric brake only for non-hovercar variants.
       #endif
 
       int16_t throttleCommand = input2[inIdx].cmd;
       int16_t brakePedalRaw = 0;
       int16_t brakeTarget = 0;
       int16_t brakeActive = 0;
       int16_t reverseRequested = 0;
       int16_t motionDir = (speedAvg > 0) ? 1 : ((speedAvg < 0) ? -1 : 0);
 
       #ifdef VARIANT_HOVERCAR
       if (inIdx == CONTROL_ADC) {                                   // Convert brake pedal input into a smooth, direction-aware speed target before filtering.
         brakePedalRaw = ABS(input1[inIdx].cmd);
         brakeActive = (brakePedalRaw > BRAKE_PEDAL_THRESHOLD);
         reverseRequested = (MultipleTapBrake.b_multipleTap && speedAvgAbs < 60) ? 1 : 0;
 
-        if (brakeActive) {
-          int32_t speedFactor = 1000;
-          if (speedAvgAbs < BRAKE_MIN_SPEED_RPM) {
-            speedFactor = 0;
-          } else if (speedAvgAbs < BRAKE_SMOOTH_ZONE_RPM) {
-            speedFactor = ((int32_t)speedAvgAbs - BRAKE_MIN_SPEED_RPM) * 1000 /
-                          (BRAKE_SMOOTH_ZONE_RPM - BRAKE_MIN_SPEED_RPM);
-          }
+        int32_t speedFactor = 1000;
+        if (speedAvgAbs < BRAKE_MIN_SPEED_RPM) {
+          speedFactor = 0;
+        } else if (speedAvgAbs < BRAKE_SMOOTH_ZONE_RPM) {
+          speedFactor = ((int32_t)speedAvgAbs - BRAKE_MIN_SPEED_RPM) * 1000 /
+                        (BRAKE_SMOOTH_ZONE_RPM - BRAKE_MIN_SPEED_RPM);
+        }
 
+        if (reverseRequested) {
+          int16_t reverseMagnitude = brakeActive ? (int16_t)((brakePedalRaw * speedFactor) / 1000) : REVERSE_SPEED_LIMIT;
+          reverseMagnitude = (int16_t)CLAMP(reverseMagnitude, 0, REVERSE_SPEED_LIMIT);
+          brakeTarget = -reverseMagnitude;
+        } else if (brakeActive) {
           int16_t brakeMagnitude = (int16_t)((brakePedalRaw * speedFactor) / 1000);
           brakeMagnitude = (int16_t)CLAMP(brakeMagnitude, 0, BRAKE_MAX_LIMIT);
 
-          if (MultipleTapBrake.b_multipleTap && speedAvgAbs < 60) {
-            brakeTarget = -(int16_t)CLAMP(brakeMagnitude, 0, REVERSE_SPEED_LIMIT);
-          } else if (speedAvg > 0) {
+          if (speedAvg > 0) {
             brakeTarget = -brakeMagnitude;
           } else if (speedAvg < 0) {
             brakeTarget =  brakeMagnitude;
           }
         }
 
         if (brakeTarget != 0) {
           int32_t brakeError = (int32_t)brakeTarget - filteredBrakeCmd;
           if (brakeError > BRAKE_RAMP_STEP) {
             filteredBrakeCmd += BRAKE_RAMP_STEP;
           } else if (brakeError < -BRAKE_RAMP_STEP) {
             filteredBrakeCmd -= BRAKE_RAMP_STEP;
           } else {
             filteredBrakeCmd = brakeTarget;
           }
-          throttleCommand = filteredBrakeCmd;
+          throttleCommand = (int16_t)CLAMP(filteredBrakeCmd, -REVERSE_SPEED_LIMIT, 1000);
         } else {
           if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
             filteredBrakeCmd -= BRAKE_RAMP_STEP;
           } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
             filteredBrakeCmd += BRAKE_RAMP_STEP;
           } else {
             filteredBrakeCmd = 0;
           }
           throttleCommand = input2[inIdx].cmd;
         }
 
         input1[inIdx].cmd = 0;
         input2[inIdx].cmd = throttleCommand;
       }
       #endif
 
       #ifdef VARIANT_SKATEBOARD
         if (input2[inIdx].cmd < 0) {                                // When Throttle is negative, it acts as brake. This condition is to make sure it goes to 0 as we reach standstill (to avoid Reverse driving) 
           if (speedAvg > 0) {                                       // Make sure the braking is opposite to the direction of motion
             input2[inIdx].cmd  = (int16_t)(( input2[inIdx].cmd * speedBlend) >> 15);
           } else {
             input2[inIdx].cmd  = (int16_t)((-input2[inIdx].cmd * speedBlend) >> 15);
           }
         }
       #endif
 
       // ####### LOW-PASS FILTER #######
       rateLimiter16(input1[inIdx].cmd, rate, &steerRateFixdt);
 
       {
         int16_t throttleRate = THROTTLE_ACCEL_RATE;
-        int16_t throttleCommand = input2[inIdx].cmd;
-        #ifdef VARIANT_HOVERCAR
-        if (inIdx == CONTROL_ADC) {
-          throttleCommand = input2[inIdx].cmd;
-        }
-        #endif
-        if ((throttleCommand << 4) < speedRateFixdt) {
+        int16_t throttleTarget = input2[inIdx].cmd;
+        if ((throttleTarget << 4) < speedRateFixdt) {
           throttleRate = THROTTLE_RELEASE_RATE;
         }
-        rateLimiter16(throttleCommand, throttleRate, &speedRateFixdt);
+        rateLimiter16(throttleTarget, throttleRate, &speedRateFixdt);
       }
 
       filtLowPass32(steerRateFixdt >> 4, FILTER, &steerFixdt);
       filtLowPass32(speedRateFixdt >> 4, FILTER, &speedFixdt);
       steer = (int16_t)(steerFixdt >> 16);  // convert fixed-point to integer
       speed = (int16_t)(speedFixdt >> 16);  // convert fixed-point to integer
 
       // ####### VARIANT_HOVERCAR #######
       #ifdef VARIANT_HOVERCAR
       if (inIdx == CONTROL_ADC) {               // Only use use implementation below if pedals are in use (ADC input)
 
         #ifdef MULTI_MODE_DRIVE
         if (speed >= max_speed) {
           speed = max_speed;
         }
         #endif
 
         steer = 0;                              // Do not apply steering to avoid side effects if STEER_COEFFICIENT is NOT 0
       }
       #endif
```

## db5058b05573 - fix倒车一旦触发就一直后退=GD32F103RCT6

- Author: nn9kjmgp47-boop <nn9kjmgp47@privaterelay.appleid.com>
- Date: 2026-06-29
- Diff:

```diff
commit db5058b05573bc0fab313bbe3e0e655b3cc80b45
Author: nn9kjmgp47-boop <nn9kjmgp47@privaterelay.appleid.com>
Date: 2026-06-29
Subject: fix倒车一旦触发就一直后退=GD32F103RCT6



diff --git a/Src/main.c b/Src/main.c
index 876cff2..43d17a1 100644
--- a/Src/main.c
+++ b/Src/main.c
@@ -278,43 +278,43 @@ int main(void) {
       int16_t brakePedalRaw = 0;
       int16_t brakeTarget = 0;
       int16_t brakeActive = 0;
       int16_t reverseRequested = 0;
       int16_t motionDir = (speedAvg > 0) ? 1 : ((speedAvg < 0) ? -1 : 0);
 
       #ifdef VARIANT_HOVERCAR
       if (inIdx == CONTROL_ADC) {                                   // Convert brake pedal input into a smooth, direction-aware speed target before filtering.
         brakePedalRaw = ABS(input1[inIdx].cmd);
         brakeActive = (brakePedalRaw > BRAKE_PEDAL_THRESHOLD);
         reverseRequested = (MultipleTapBrake.b_multipleTap && speedAvgAbs < 60) ? 1 : 0;
 
         int32_t speedFactor = 1000;
         if (speedAvgAbs < BRAKE_MIN_SPEED_RPM) {
           speedFactor = 0;
         } else if (speedAvgAbs < BRAKE_SMOOTH_ZONE_RPM) {
           speedFactor = ((int32_t)speedAvgAbs - BRAKE_MIN_SPEED_RPM) * 1000 /
                         (BRAKE_SMOOTH_ZONE_RPM - BRAKE_MIN_SPEED_RPM);
         }
 
-        if (reverseRequested) {
-          int16_t reverseMagnitude = brakeActive ? (int16_t)((brakePedalRaw * speedFactor) / 1000) : REVERSE_SPEED_LIMIT;
-          reverseMagnitude = (int16_t)CLAMP(reverseMagnitude, 0, REVERSE_SPEED_LIMIT);
+        int16_t throttleInputMag = ABS(input2[inIdx].cmd);
+        if (reverseRequested && throttleInputMag > 10) {
+          int16_t reverseMagnitude = (int16_t)CLAMP(throttleInputMag, 0, REVERSE_SPEED_LIMIT);
           brakeTarget = -reverseMagnitude;
         } else if (brakeActive) {
           int16_t brakeMagnitude = (int16_t)((brakePedalRaw * speedFactor) / 1000);
           brakeMagnitude = (int16_t)CLAMP(brakeMagnitude, 0, BRAKE_MAX_LIMIT);
 
           if (speedAvg > 0) {
             brakeTarget = -brakeMagnitude;
           } else if (speedAvg < 0) {
             brakeTarget =  brakeMagnitude;
           }
         }
 
         if (brakeTarget != 0) {
           int32_t brakeError = (int32_t)brakeTarget - filteredBrakeCmd;
           if (brakeError > BRAKE_RAMP_STEP) {
             filteredBrakeCmd += BRAKE_RAMP_STEP;
           } else if (brakeError < -BRAKE_RAMP_STEP) {
             filteredBrakeCmd -= BRAKE_RAMP_STEP;
           } else {
             filteredBrakeCmd = brakeTarget;
```

## 05046b860b9f - fix完全不踩油门也不踩刹车”时会稳定回到 0。=GD32F103RCT6

- Author: nn9kjmgp47-boop <nn9kjmgp47@privaterelay.appleid.com>
- Date: 2026-06-29
- Diff:

```diff
commit 05046b860b9f7ae248bf28849c5f2c5b8dc5f2ec
Author: nn9kjmgp47-boop <nn9kjmgp47@privaterelay.appleid.com>
Date: 2026-06-29
Subject: fix完全不踩油门也不踩刹车”时会稳定回到 0。=GD32F103RCT6



diff --git a/Src/main.c b/Src/main.c
index 43d17a1..bf35603 100644
--- a/Src/main.c
+++ b/Src/main.c
@@ -258,94 +258,96 @@ int main(void) {
         standstillHold();                                           // Apply Standstill Hold functionality. Only available and makes sense for VOLTAGE or TORQUE Mode
       #endif
 
       #ifdef VARIANT_HOVERCAR
       if (inIdx == CONTROL_ADC) {                                   // Only use use implementation below if pedals are in use (ADC input)
         if (speedAvgAbs < 60) {                                     // Check if Hovercar is physically close to standstill to enable Double tap detection on Brake pedal for Reverse functionality
           multipleTapDet(input1[inIdx].cmd, HAL_GetTick(), &MultipleTapBrake); // Brake pedal in this case is "input1" variable
         }
 
         if (input1[inIdx].cmd > 30) {                               // Brake pedal pressed: deactivate cruise control while braking
           cruiseControl((uint8_t)rtP_Left.b_cruiseCtrlEna);         // Cruise control deactivated by Brake pedal if it was active
         }
       }
       #endif
 
       #if defined(ELECTRIC_BRAKE_ENABLE) && !defined(VARIANT_HOVERCAR)
         electricBrake(speedBlend, 0);  // Apply electric brake only for non-hovercar variants.
       #endif
 
       int16_t throttleCommand = input2[inIdx].cmd;
+      int16_t rawThrottleCmd = input2[inIdx].cmd;
       int16_t brakePedalRaw = 0;
       int16_t brakeTarget = 0;
       int16_t brakeActive = 0;
       int16_t reverseRequested = 0;
       int16_t motionDir = (speedAvg > 0) ? 1 : ((speedAvg < 0) ? -1 : 0);
 
       #ifdef VARIANT_HOVERCAR
       if (inIdx == CONTROL_ADC) {                                   // Convert brake pedal input into a smooth, direction-aware speed target before filtering.
+        if (ABS(rawThrottleCmd) < 10) {
+          rawThrottleCmd = 0;
+        }
         brakePedalRaw = ABS(input1[inIdx].cmd);
         brakeActive = (brakePedalRaw > BRAKE_PEDAL_THRESHOLD);
         reverseRequested = (MultipleTapBrake.b_multipleTap && speedAvgAbs < 60) ? 1 : 0;
 
         int32_t speedFactor = 1000;
         if (speedAvgAbs < BRAKE_MIN_SPEED_RPM) {
           speedFactor = 0;
         } else if (speedAvgAbs < BRAKE_SMOOTH_ZONE_RPM) {
           speedFactor = ((int32_t)speedAvgAbs - BRAKE_MIN_SPEED_RPM) * 1000 /
                         (BRAKE_SMOOTH_ZONE_RPM - BRAKE_MIN_SPEED_RPM);
         }
 
-        int16_t throttleInputMag = ABS(input2[inIdx].cmd);
+        int16_t throttleInputMag = ABS(rawThrottleCmd);
         if (reverseRequested && throttleInputMag > 10) {
           int16_t reverseMagnitude = (int16_t)CLAMP(throttleInputMag, 0, REVERSE_SPEED_LIMIT);
-          brakeTarget = -reverseMagnitude;
-        } else if (brakeActive) {
-          int16_t brakeMagnitude = (int16_t)((brakePedalRaw * speedFactor) / 1000);
-          brakeMagnitude = (int16_t)CLAMP(brakeMagnitude, 0, BRAKE_MAX_LIMIT);
-
-          if (speedAvg > 0) {
-            brakeTarget = -brakeMagnitude;
-          } else if (speedAvg < 0) {
-            brakeTarget =  brakeMagnitude;
+          filteredBrakeCmd = 0;
+          throttleCommand = (int16_t)(-reverseMagnitude);
+        } else {
+          int16_t brakeMagnitude = 0;
+          if (brakeActive) {
+            brakeMagnitude = (int16_t)((brakePedalRaw * speedFactor) / 1000);
+            brakeMagnitude = (int16_t)CLAMP(brakeMagnitude, 0, BRAKE_MAX_LIMIT);
           }
-        }
 
-        if (brakeTarget != 0) {
-          int32_t brakeError = (int32_t)brakeTarget - filteredBrakeCmd;
-          if (brakeError > BRAKE_RAMP_STEP) {
-            filteredBrakeCmd += BRAKE_RAMP_STEP;
-          } else if (brakeError < -BRAKE_RAMP_STEP) {
-            filteredBrakeCmd -= BRAKE_RAMP_STEP;
-          } else {
-            filteredBrakeCmd = brakeTarget;
-          }
-          throttleCommand = (int16_t)CLAMP(filteredBrakeCmd, -REVERSE_SPEED_LIMIT, 1000);
-        } else {
-          if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
-            filteredBrakeCmd -= BRAKE_RAMP_STEP;
-          } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
-            filteredBrakeCmd += BRAKE_RAMP_STEP;
+          if (brakeMagnitude > 0) {
+            int32_t brakeError = (int32_t)brakeMagnitude - filteredBrakeCmd;
+            if (brakeError > BRAKE_RAMP_STEP) {
+              filteredBrakeCmd += BRAKE_RAMP_STEP;
+            } else if (brakeError < -BRAKE_RAMP_STEP) {
+              filteredBrakeCmd -= BRAKE_RAMP_STEP;
+            } else {
+              filteredBrakeCmd = brakeMagnitude;
+            }
+            throttleCommand = 0;
           } else {
-            filteredBrakeCmd = 0;
+            if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
+              filteredBrakeCmd -= BRAKE_RAMP_STEP;
+            } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
+              filteredBrakeCmd += BRAKE_RAMP_STEP;
+            } else {
+              filteredBrakeCmd = 0;
+            }
+            throttleCommand = (ABS(rawThrottleCmd) < 10) ? 0 : rawThrottleCmd;
           }
-          throttleCommand = input2[inIdx].cmd;
         }
 
         input1[inIdx].cmd = 0;
         input2[inIdx].cmd = throttleCommand;
       }
       #endif
 
       #ifdef VARIANT_SKATEBOARD
         if (input2[inIdx].cmd < 0) {                                // When Throttle is negative, it acts as brake. This condition is to make sure it goes to 0 as we reach standstill (to avoid Reverse driving) 
           if (speedAvg > 0) {                                       // Make sure the braking is opposite to the direction of motion
             input2[inIdx].cmd  = (int16_t)(( input2[inIdx].cmd * speedBlend) >> 15);
           } else {
             input2[inIdx].cmd  = (int16_t)((-input2[inIdx].cmd * speedBlend) >> 15);
           }
         }
       #endif
 
       // ####### LOW-PASS FILTER #######
       rateLimiter16(input1[inIdx].cmd, rate, &steerRateFixdt);
```

## f3e4a2a46d58 - fix刹车被检测到以后，前进命令并没有真正被截断=GD32F103RCT6

- Author: nn9kjmgp47-boop <nn9kjmgp47@privaterelay.appleid.com>
- Date: 2026-06-29
- Diff:

```diff
commit f3e4a2a46d5841d2f4cdc5244c12e4f34acfbd01
Author: nn9kjmgp47-boop <nn9kjmgp47@privaterelay.appleid.com>
Date: 2026-06-29
Subject: fix刹车被检测到以后，前进命令并没有真正被截断=GD32F103RCT6



diff --git a/Src/main.c b/Src/main.c
index bf35603..2ba1781 100644
--- a/Src/main.c
+++ b/Src/main.c
@@ -290,54 +290,71 @@ int main(void) {
         brakePedalRaw = ABS(input1[inIdx].cmd);
         brakeActive = (brakePedalRaw > BRAKE_PEDAL_THRESHOLD);
         reverseRequested = (MultipleTapBrake.b_multipleTap && speedAvgAbs < 60) ? 1 : 0;
 
         int32_t speedFactor = 1000;
         if (speedAvgAbs < BRAKE_MIN_SPEED_RPM) {
           speedFactor = 0;
         } else if (speedAvgAbs < BRAKE_SMOOTH_ZONE_RPM) {
           speedFactor = ((int32_t)speedAvgAbs - BRAKE_MIN_SPEED_RPM) * 1000 /
                         (BRAKE_SMOOTH_ZONE_RPM - BRAKE_MIN_SPEED_RPM);
         }
 
         int16_t throttleInputMag = ABS(rawThrottleCmd);
         if (reverseRequested && throttleInputMag > 10) {
           int16_t reverseMagnitude = (int16_t)CLAMP(throttleInputMag, 0, REVERSE_SPEED_LIMIT);
           filteredBrakeCmd = 0;
           throttleCommand = (int16_t)(-reverseMagnitude);
         } else {
           int16_t brakeMagnitude = 0;
           if (brakeActive) {
-            brakeMagnitude = (int16_t)((brakePedalRaw * speedFactor) / 1000);
-            brakeMagnitude = (int16_t)CLAMP(brakeMagnitude, 0, BRAKE_MAX_LIMIT);
+            int32_t pedalScaled = (int32_t)brakePedalRaw;
+            if (speedAvgAbs < BRAKE_MIN_SPEED_RPM) {
+              pedalScaled = (pedalScaled * 1000) / 1000;
+            } else if (speedAvgAbs < BRAKE_SMOOTH_ZONE_RPM) {
+              pedalScaled = (pedalScaled * speedFactor) / 1000;
+            } else {
+              pedalScaled = (pedalScaled * speedFactor) / 1000;
+            }
+            brakeMagnitude = (int16_t)CLAMP(pedalScaled, 0, BRAKE_MAX_LIMIT);
           }
 
-          if (brakeMagnitude > 0) {
-            int32_t brakeError = (int32_t)brakeMagnitude - filteredBrakeCmd;
-            if (brakeError > BRAKE_RAMP_STEP) {
-              filteredBrakeCmd += BRAKE_RAMP_STEP;
-            } else if (brakeError < -BRAKE_RAMP_STEP) {
-              filteredBrakeCmd -= BRAKE_RAMP_STEP;
+          if (brakeActive) {
+            throttleCommand = 0;
+            if (brakeMagnitude > 0) {
+              int32_t brakeError = (int32_t)brakeMagnitude - filteredBrakeCmd;
+              if (brakeError > BRAKE_RAMP_STEP) {
+                filteredBrakeCmd += BRAKE_RAMP_STEP;
+              } else if (brakeError < -BRAKE_RAMP_STEP) {
+                filteredBrakeCmd -= BRAKE_RAMP_STEP;
+              } else {
+                filteredBrakeCmd = brakeMagnitude;
+              }
             } else {
-              filteredBrakeCmd = brakeMagnitude;
+              if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
+                filteredBrakeCmd -= BRAKE_RAMP_STEP;
+              } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
+                filteredBrakeCmd += BRAKE_RAMP_STEP;
+              } else {
+                filteredBrakeCmd = 0;
+              }
             }
-            throttleCommand = 0;
           } else {
             if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
               filteredBrakeCmd -= BRAKE_RAMP_STEP;
             } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
               filteredBrakeCmd += BRAKE_RAMP_STEP;
             } else {
               filteredBrakeCmd = 0;
             }
             throttleCommand = (ABS(rawThrottleCmd) < 10) ? 0 : rawThrottleCmd;
           }
         }
 
         input1[inIdx].cmd = 0;
         input2[inIdx].cmd = throttleCommand;
       }
       #endif
 
       #ifdef VARIANT_SKATEBOARD
         if (input2[inIdx].cmd < 0) {                                // When Throttle is negative, it acts as brake. This condition is to make sure it goes to 0 as we reach standstill (to avoid Reverse driving) 
           if (speedAvg > 0) {                                       // Make sure the braking is opposite to the direction of motion
```

## 3a18dbc0fc98 - fix刹车踩下时确实会把 fs/thr 清零，但一旦松开刹车，车子又因为“油门仍然被按住”而立即重新前冲=GD32F103RCT6

- Author: nn9kjmgp47-boop <nn9kjmgp47@privaterelay.appleid.com>
- Date: 2026-06-29
- Diff:

```diff
commit 3a18dbc0fc98c9dac378216fa7a4aec2bdc44843
Author: nn9kjmgp47-boop <nn9kjmgp47@privaterelay.appleid.com>
Date: 2026-06-29
Subject: fix刹车踩下时确实会把 fs/thr 清零，但一旦松开刹车，车子又因为“油门仍然被按住”而立即重新前冲=GD32F103RCT6



diff --git a/Src/main.c b/Src/main.c
index 2ba1781..d8e6810 100644
--- a/Src/main.c
+++ b/Src/main.c
@@ -122,40 +122,41 @@ static uint8_t sideboard_leds_R;
   static uint8_t  checkRemote = 0;
   static uint16_t distance;
   static float    steering;
   static int      distanceErr;  
   static int      lastDistance = 0;
   static uint16_t transpotter_counter = 0;
 #endif
 
 static int16_t    speed;                // local variable for speed. -1000 to 1000
 #ifndef VARIANT_TRANSPOTTER
   static int16_t  steer;                // local variable for steering. -1000 to 1000
   static int16_t  steerRateFixdt;       // local fixed-point variable for steering rate limiter
   static int16_t  speedRateFixdt;       // local fixed-point variable for speed rate limiter
   static int32_t  steerFixdt;           // local fixed-point variable for steering low-pass filter
   static int32_t  speedFixdt;           // local fixed-point variable for speed low-pass filter
 #endif
 
 static uint32_t    buzzerTimer_prev = 0;
 static uint32_t    inactivity_timeout_counter;
 static int16_t     filteredBrakeCmd = 0;
+static uint8_t     brakeThrottleLock = 0;
 static MultipleTap MultipleTapBrake;    // define multiple tap functionality for the Brake pedal
 
 static uint16_t rate = RATE; // Adjustable rate to support multiple drive modes on startup
 
 #ifdef MULTI_MODE_DRIVE
   static uint8_t drive_mode;
   static uint16_t max_speed;
 #endif
 
 
 int main(void) {
 
   HAL_Init();
   __HAL_RCC_AFIO_CLK_ENABLE();
   HAL_NVIC_SetPriorityGrouping(NVIC_PRIORITYGROUP_4);
   /* System interrupt init*/
   /* MemoryManagement_IRQn interrupt configuration */
   HAL_NVIC_SetPriority(MemoryManagement_IRQn, 0, 0);
   /* BusFault_IRQn interrupt configuration */
   HAL_NVIC_SetPriority(BusFault_IRQn, 0, 0);
@@ -302,59 +303,75 @@ int main(void) {
         int16_t throttleInputMag = ABS(rawThrottleCmd);
         if (reverseRequested && throttleInputMag > 10) {
           int16_t reverseMagnitude = (int16_t)CLAMP(throttleInputMag, 0, REVERSE_SPEED_LIMIT);
           filteredBrakeCmd = 0;
           throttleCommand = (int16_t)(-reverseMagnitude);
         } else {
           int16_t brakeMagnitude = 0;
           if (brakeActive) {
             int32_t pedalScaled = (int32_t)brakePedalRaw;
             if (speedAvgAbs < BRAKE_MIN_SPEED_RPM) {
               pedalScaled = (pedalScaled * 1000) / 1000;
             } else if (speedAvgAbs < BRAKE_SMOOTH_ZONE_RPM) {
               pedalScaled = (pedalScaled * speedFactor) / 1000;
             } else {
               pedalScaled = (pedalScaled * speedFactor) / 1000;
             }
             brakeMagnitude = (int16_t)CLAMP(pedalScaled, 0, BRAKE_MAX_LIMIT);
           }
 
           if (brakeActive) {
+            brakeThrottleLock = 1;
             throttleCommand = 0;
             if (brakeMagnitude > 0) {
               int32_t brakeError = (int32_t)brakeMagnitude - filteredBrakeCmd;
               if (brakeError > BRAKE_RAMP_STEP) {
                 filteredBrakeCmd += BRAKE_RAMP_STEP;
               } else if (brakeError < -BRAKE_RAMP_STEP) {
                 filteredBrakeCmd -= BRAKE_RAMP_STEP;
               } else {
                 filteredBrakeCmd = brakeMagnitude;
               }
             } else {
               if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
                 filteredBrakeCmd -= BRAKE_RAMP_STEP;
               } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
                 filteredBrakeCmd += BRAKE_RAMP_STEP;
               } else {
                 filteredBrakeCmd = 0;
               }
             }
+          } else if (brakeThrottleLock) {
+            if (ABS(rawThrottleCmd) < 10) {
+              brakeThrottleLock = 0;
+              throttleCommand = 0;
+            } else {
+              throttleCommand = 0;
+            }
+
+            if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
+              filteredBrakeCmd -= BRAKE_RAMP_STEP;
+            } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
+              filteredBrakeCmd += BRAKE_RAMP_STEP;
+            } else {
+              filteredBrakeCmd = 0;
+            }
           } else {
             if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
               filteredBrakeCmd -= BRAKE_RAMP_STEP;
             } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
               filteredBrakeCmd += BRAKE_RAMP_STEP;
             } else {
               filteredBrakeCmd = 0;
             }
             throttleCommand = (ABS(rawThrottleCmd) < 10) ? 0 : rawThrottleCmd;
           }
         }
 
         input1[inIdx].cmd = 0;
         input2[inIdx].cmd = throttleCommand;
       }
       #endif
 
       #ifdef VARIANT_SKATEBOARD
         if (input2[inIdx].cmd < 0) {                                // When Throttle is negative, it acts as brake. This condition is to make sure it goes to 0 as we reach standstill (to avoid Reverse driving) 
           if (speedAvg > 0) {                                       // Make sure the braking is opposite to the direction of motion
```

## 06ca0d894917 - fix刹车生成真正的反向制动力命令”。=GD32F103RCT6

- Author: nn9kjmgp47-boop <nn9kjmgp47@privaterelay.appleid.com>
- Date: 2026-06-29
- Diff:

```diff
commit 06ca0d89491754339693824c31866d5ec7bba756
Author: nn9kjmgp47-boop <nn9kjmgp47@privaterelay.appleid.com>
Date: 2026-06-29
Subject: fix刹车生成真正的反向制动力命令”。=GD32F103RCT6



diff --git a/Src/main.c b/Src/main.c
index d8e6810..47cbce7 100644
--- a/Src/main.c
+++ b/Src/main.c
@@ -304,59 +304,66 @@ int main(void) {
         if (reverseRequested && throttleInputMag > 10) {
           int16_t reverseMagnitude = (int16_t)CLAMP(throttleInputMag, 0, REVERSE_SPEED_LIMIT);
           filteredBrakeCmd = 0;
           throttleCommand = (int16_t)(-reverseMagnitude);
         } else {
           int16_t brakeMagnitude = 0;
           if (brakeActive) {
             int32_t pedalScaled = (int32_t)brakePedalRaw;
             if (speedAvgAbs < BRAKE_MIN_SPEED_RPM) {
               pedalScaled = (pedalScaled * 1000) / 1000;
             } else if (speedAvgAbs < BRAKE_SMOOTH_ZONE_RPM) {
               pedalScaled = (pedalScaled * speedFactor) / 1000;
             } else {
               pedalScaled = (pedalScaled * speedFactor) / 1000;
             }
             brakeMagnitude = (int16_t)CLAMP(pedalScaled, 0, BRAKE_MAX_LIMIT);
           }
 
           if (brakeActive) {
             brakeThrottleLock = 1;
-            throttleCommand = 0;
             if (brakeMagnitude > 0) {
               int32_t brakeError = (int32_t)brakeMagnitude - filteredBrakeCmd;
               if (brakeError > BRAKE_RAMP_STEP) {
                 filteredBrakeCmd += BRAKE_RAMP_STEP;
               } else if (brakeError < -BRAKE_RAMP_STEP) {
                 filteredBrakeCmd -= BRAKE_RAMP_STEP;
               } else {
                 filteredBrakeCmd = brakeMagnitude;
               }
             } else {
               if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
                 filteredBrakeCmd -= BRAKE_RAMP_STEP;
               } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
                 filteredBrakeCmd += BRAKE_RAMP_STEP;
               } else {
                 filteredBrakeCmd = 0;
               }
             }
+
+            if (speedAvg > 0) {
+              throttleCommand = (int16_t)(-filteredBrakeCmd);
+            } else if (speedAvg < 0) {
+              throttleCommand = (int16_t)(filteredBrakeCmd);
+            } else {
+              throttleCommand = 0;
+            }
           } else if (brakeThrottleLock) {
             if (ABS(rawThrottleCmd) < 10) {
               brakeThrottleLock = 0;
               throttleCommand = 0;
             } else {
               throttleCommand = 0;
             }
 
             if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
               filteredBrakeCmd -= BRAKE_RAMP_STEP;
             } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
               filteredBrakeCmd += BRAKE_RAMP_STEP;
             } else {
               filteredBrakeCmd = 0;
             }
           } else {
             if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
               filteredBrakeCmd -= BRAKE_RAMP_STEP;
             } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
               filteredBrakeCmd += BRAKE_RAMP_STEP;
```

## dda6de795dc3 - fix刹车按下，轻微拨动轮子，轮子会反向过冲。而不是平滑电子阻尼=GD32F103RCT6

- Author: nn9kjmgp47-boop <nn9kjmgp47@privaterelay.appleid.com>
- Date: 2026-06-29
- Diff:

```diff
commit dda6de795dc3556caf21d8f152fd946670e62de6
Author: nn9kjmgp47-boop <nn9kjmgp47@privaterelay.appleid.com>
Date: 2026-06-29
Subject: fix刹车按下，轻微拨动轮子，轮子会反向过冲。而不是平滑电子阻尼=GD32F103RCT6



diff --git a/Src/main.c b/Src/main.c
index 47cbce7..a164ae5 100644
--- a/Src/main.c
+++ b/Src/main.c
@@ -323,41 +323,44 @@ int main(void) {
             brakeThrottleLock = 1;
             if (brakeMagnitude > 0) {
               int32_t brakeError = (int32_t)brakeMagnitude - filteredBrakeCmd;
               if (brakeError > BRAKE_RAMP_STEP) {
                 filteredBrakeCmd += BRAKE_RAMP_STEP;
               } else if (brakeError < -BRAKE_RAMP_STEP) {
                 filteredBrakeCmd -= BRAKE_RAMP_STEP;
               } else {
                 filteredBrakeCmd = brakeMagnitude;
               }
             } else {
               if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
                 filteredBrakeCmd -= BRAKE_RAMP_STEP;
               } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
                 filteredBrakeCmd += BRAKE_RAMP_STEP;
               } else {
                 filteredBrakeCmd = 0;
               }
             }
 
-            if (speedAvg > 0) {
+            if (speedAvgAbs < BRAKE_SMOOTH_ZONE_RPM) {
+              int32_t dampingCmd = ((int32_t)filteredBrakeCmd * (int32_t)ABS(speedAvg)) / BRAKE_SMOOTH_ZONE_RPM;
+              throttleCommand = (speedAvg >= 0) ? (int16_t)(-dampingCmd) : (int16_t)(dampingCmd);
+            } else if (speedAvg > 0) {
               throttleCommand = (int16_t)(-filteredBrakeCmd);
             } else if (speedAvg < 0) {
               throttleCommand = (int16_t)(filteredBrakeCmd);
             } else {
               throttleCommand = 0;
             }
           } else if (brakeThrottleLock) {
             if (ABS(rawThrottleCmd) < 10) {
               brakeThrottleLock = 0;
               throttleCommand = 0;
             } else {
               throttleCommand = 0;
             }
 
             if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
               filteredBrakeCmd -= BRAKE_RAMP_STEP;
             } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
               filteredBrakeCmd += BRAKE_RAMP_STEP;
             } else {
               filteredBrakeCmd = 0;
```

## 1cafe4b4a734 - 防止在进入倒车后（如拔掉刹车线导致读值为“按下”或异常抖动）仍然持续倒车=GD32F103RCT6

- Author: Too large to fit in the margin <qgbcs@outlook.com>
- Date: 2026-06-29
- Diff:

```diff
commit 1cafe4b4a734c7c5d12fb7135a34bc5a35eac170
Author: Too large to fit in the margin <qgbcs@outlook.com>
Date: 2026-06-29
Subject: 防止在进入倒车后（如拔掉刹车线导致读值为“按下”或异常抖动）仍然持续倒车=GD32F103RCT6



diff --git a/Src/main.c b/Src/main.c
index a164ae5..eb2e971 100644
--- a/Src/main.c
+++ b/Src/main.c
@@ -360,40 +360,51 @@ int main(void) {
 
             if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
               filteredBrakeCmd -= BRAKE_RAMP_STEP;
             } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
               filteredBrakeCmd += BRAKE_RAMP_STEP;
             } else {
               filteredBrakeCmd = 0;
             }
           } else {
             if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
               filteredBrakeCmd -= BRAKE_RAMP_STEP;
             } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
               filteredBrakeCmd += BRAKE_RAMP_STEP;
             } else {
               filteredBrakeCmd = 0;
             }
             throttleCommand = (ABS(rawThrottleCmd) < 10) ? 0 : rawThrottleCmd;
           }
         }
 
+        /* Safety: if we started reversing but the brake pedal is detected as pressed
+           (e.g. unplugged wiring that reads as pressed), immediately stop reversing. */
+        if (reverseRequested && throttleCommand < 0 && brakeActive) {
+          #if defined(DEBUG_SERIAL_USART2) || defined(DEBUG_SERIAL_USART3)
+          printf("Reverse blocked: brake pressed - stopping immediately\r\n");
+          #endif
+          throttleCommand = 0;         // cancel reverse throttle
+          brakeThrottleLock = 1;      // lock throttle until pedal released
+          filteredBrakeCmd = BRAKE_MAX_LIMIT; // apply full brake command to stop
+        }
+
         input1[inIdx].cmd = 0;
         input2[inIdx].cmd = throttleCommand;
       }
       #endif
 
       #ifdef VARIANT_SKATEBOARD
         if (input2[inIdx].cmd < 0) {                                // When Throttle is negative, it acts as brake. This condition is to make sure it goes to 0 as we reach standstill (to avoid Reverse driving) 
           if (speedAvg > 0) {                                       // Make sure the braking is opposite to the direction of motion
             input2[inIdx].cmd  = (int16_t)(( input2[inIdx].cmd * speedBlend) >> 15);
           } else {
             input2[inIdx].cmd  = (int16_t)((-input2[inIdx].cmd * speedBlend) >> 15);
           }
         }
       #endif
 
       // ####### LOW-PASS FILTER #######
       rateLimiter16(input1[inIdx].cmd, rate, &steerRateFixdt);
 
       {
         int16_t throttleRate = THROTTLE_ACCEL_RATE;
@@ -415,42 +426,54 @@ int main(void) {
 
         #ifdef MULTI_MODE_DRIVE
         if (speed >= max_speed) {
           speed = max_speed;
         }
         #endif
 
         steer = 0;                              // Do not apply steering to avoid side effects if STEER_COEFFICIENT is NOT 0
       }
       #endif
 
       #if defined(TANK_STEERING) && !defined(VARIANT_HOVERCAR) && !defined(VARIANT_SKATEBOARD) 
         // Tank steering (no mixing)
         cmdL = steer; 
         cmdR = speed;
       #else 
         // ####### MIXER #######
         mixerFcn(speed << 4, steer << 4, &cmdR, &cmdL);   // This function implements the equations above
       #endif
 
+        // Safety: if ADC timeout (sensor lines disconnected) disable motors immediately
+        if (timeoutFlgADC) {
+          // Zero commands and disable outputs
+          cmdL = 0;
+          cmdR = 0;
+          pwml = 0;
+          pwmr = 0;
+          enable = 0;
+          #if defined(DEBUG_SERIAL_USART2) || defined(DEBUG_SERIAL_USART3)
+          printf("ADC timeout detected - motors disabled\r\n");
+          #endif
+        }
 
-      // ####### SET OUTPUTS (if the target change is less than +/- 100) #######
+        // ####### SET OUTPUTS (if the target change is less than +/- 100) #######
       #ifdef INVERT_R_DIRECTION
         pwmr = cmdR;
       #else
         pwmr = -cmdR;
       #endif
       #ifdef INVERT_L_DIRECTION
         pwml = -cmdL;
       #else
         pwml = cmdL;
       #endif
     #endif
 
     #ifdef VARIANT_TRANSPOTTER
       distance    = CLAMP(input1[inIdx].cmd - 180, 0, 4095);
       steering    = (input2[inIdx].cmd - 2048) / 2048.0;
       distanceErr = distance - (int)(setDistance * 1345);
 
       if (nunchuk_connected == 0) {
         cmdL = cmdL * 0.8f + (CLAMP(distanceErr + (steering*((float)MAX(ABS(distanceErr), 50)) * ROT_P), -850, 850) * -0.2f);
         cmdR = cmdR * 0.8f + (CLAMP(distanceErr - (steering*((float)MAX(ABS(distanceErr), 50)) * ROT_P), -850, 850) * -0.2f);
```

## 50c9245ebbbb - ：统一处理按下刹车时取消油门、锁定油门，并在松开刹车后要求油门回到近零才解除锁定。=GD32F103RCT6

- Author: Too large to fit in the margin <qgbcs@outlook.com>
- Date: 2026-06-29
- Diff:

```diff
commit 50c9245ebbbba6fc8d1582f47272bbeb5ee7193d
Author: Too large to fit in the margin <qgbcs@outlook.com>
Date: 2026-06-29
Subject: ：统一处理按下刹车时取消油门、锁定油门，并在松开刹车后要求油门回到近零才解除锁定。=GD32F103RCT6



diff --git a/Src/main.c b/Src/main.c
index eb2e971..11bdda4 100644
--- a/Src/main.c
+++ b/Src/main.c
@@ -127,40 +127,61 @@ static uint8_t sideboard_leds_R;
   static uint16_t transpotter_counter = 0;
 #endif
 
 static int16_t    speed;                // local variable for speed. -1000 to 1000
 #ifndef VARIANT_TRANSPOTTER
   static int16_t  steer;                // local variable for steering. -1000 to 1000
   static int16_t  steerRateFixdt;       // local fixed-point variable for steering rate limiter
   static int16_t  speedRateFixdt;       // local fixed-point variable for speed rate limiter
   static int32_t  steerFixdt;           // local fixed-point variable for steering low-pass filter
   static int32_t  speedFixdt;           // local fixed-point variable for speed low-pass filter
 #endif
 
 static uint32_t    buzzerTimer_prev = 0;
 static uint32_t    inactivity_timeout_counter;
 static int16_t     filteredBrakeCmd = 0;
 static uint8_t     brakeThrottleLock = 0;
 static MultipleTap MultipleTapBrake;    // define multiple tap functionality for the Brake pedal
 
 static uint16_t rate = RATE; // Adjustable rate to support multiple drive modes on startup
 
+/*
+ * Brake interlock helper
+ * - When `brakeActive` is true: cancel any throttle, lock throttle until
+ *   the physical throttle returns to near-zero to avoid sudden re-acceleration.
+ * - When `brakeThrottleLock` is set: keep throttle at zero until `rawThrottleCmd` small.
+ */
+static void apply_brake_interlock(int16_t *throttleCommand, int16_t rawThrottleCmd, uint8_t brakeActive) {
+  if (brakeActive) {
+    *throttleCommand = 0;
+    brakeThrottleLock = 1;
+    filteredBrakeCmd = BRAKE_MAX_LIMIT; // request full braking to stop quickly
+  } else if (brakeThrottleLock) {
+    if (ABS(rawThrottleCmd) < 10) {
+      brakeThrottleLock = 0; // release lock only when throttle is near zero
+      *throttleCommand = 0;
+    } else {
+      *throttleCommand = 0; // keep throttle zero while locked
+    }
+  }
+}
+
 #ifdef MULTI_MODE_DRIVE
   static uint8_t drive_mode;
   static uint16_t max_speed;
 #endif
 
 
 int main(void) {
 
   HAL_Init();
   __HAL_RCC_AFIO_CLK_ENABLE();
   HAL_NVIC_SetPriorityGrouping(NVIC_PRIORITYGROUP_4);
   /* System interrupt init*/
   /* MemoryManagement_IRQn interrupt configuration */
   HAL_NVIC_SetPriority(MemoryManagement_IRQn, 0, 0);
   /* BusFault_IRQn interrupt configuration */
   HAL_NVIC_SetPriority(BusFault_IRQn, 0, 0);
   /* UsageFault_IRQn interrupt configuration */
   HAL_NVIC_SetPriority(UsageFault_IRQn, 0, 0);
   /* SVCall_IRQn interrupt configuration */
   HAL_NVIC_SetPriority(SVCall_IRQn, 0, 0);
@@ -360,50 +381,42 @@ int main(void) {
 
             if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
               filteredBrakeCmd -= BRAKE_RAMP_STEP;
             } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
               filteredBrakeCmd += BRAKE_RAMP_STEP;
             } else {
               filteredBrakeCmd = 0;
             }
           } else {
             if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
               filteredBrakeCmd -= BRAKE_RAMP_STEP;
             } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
               filteredBrakeCmd += BRAKE_RAMP_STEP;
             } else {
               filteredBrakeCmd = 0;
             }
             throttleCommand = (ABS(rawThrottleCmd) < 10) ? 0 : rawThrottleCmd;
           }
         }
 
-        /* Safety: if we started reversing but the brake pedal is detected as pressed
-           (e.g. unplugged wiring that reads as pressed), immediately stop reversing. */
-        if (reverseRequested && throttleCommand < 0 && brakeActive) {
-          #if defined(DEBUG_SERIAL_USART2) || defined(DEBUG_SERIAL_USART3)
-          printf("Reverse blocked: brake pressed - stopping immediately\r\n");
-          #endif
-          throttleCommand = 0;         // cancel reverse throttle
-          brakeThrottleLock = 1;      // lock throttle until pedal released
-          filteredBrakeCmd = BRAKE_MAX_LIMIT; // apply full brake command to stop
-        }
+        // Apply unified brake interlock for both forward and reverse
+        apply_brake_interlock(&throttleCommand, rawThrottleCmd, brakeActive);
 
         input1[inIdx].cmd = 0;
         input2[inIdx].cmd = throttleCommand;
       }
       #endif
 
       #ifdef VARIANT_SKATEBOARD
         if (input2[inIdx].cmd < 0) {                                // When Throttle is negative, it acts as brake. This condition is to make sure it goes to 0 as we reach standstill (to avoid Reverse driving) 
           if (speedAvg > 0) {                                       // Make sure the braking is opposite to the direction of motion
             input2[inIdx].cmd  = (int16_t)(( input2[inIdx].cmd * speedBlend) >> 15);
           } else {
             input2[inIdx].cmd  = (int16_t)((-input2[inIdx].cmd * speedBlend) >> 15);
           }
         }
       #endif
 
       // ####### LOW-PASS FILTER #######
       rateLimiter16(input1[inIdx].cmd, rate, &steerRateFixdt);
 
       {
```

## 4c2d056fef12 - fix取消所有油门/扭矩”的命令，误把原本用来产生制动扭矩的 throttleCommand 也清零了=GD32F103RCT6

- Author: Too large to fit in the margin <qgbcs@outlook.com>
- Date: 2026-06-29
- Diff:

```diff
commit 4c2d056fef123ce2da225ae5fd644b42983f798c
Author: Too large to fit in the margin <qgbcs@outlook.com>
Date: 2026-06-29
Subject: fix取消所有油门/扭矩”的命令，误把原本用来产生制动扭矩的 throttleCommand 也清零了=GD32F103RCT6



diff --git a/Src/main.c b/Src/main.c
index 11bdda4..db828ec 100644
--- a/Src/main.c
+++ b/Src/main.c
@@ -133,51 +133,56 @@ static int16_t    speed;                // local variable for speed. -1000 to 10
   static int16_t  steerRateFixdt;       // local fixed-point variable for steering rate limiter
   static int16_t  speedRateFixdt;       // local fixed-point variable for speed rate limiter
   static int32_t  steerFixdt;           // local fixed-point variable for steering low-pass filter
   static int32_t  speedFixdt;           // local fixed-point variable for speed low-pass filter
 #endif
 
 static uint32_t    buzzerTimer_prev = 0;
 static uint32_t    inactivity_timeout_counter;
 static int16_t     filteredBrakeCmd = 0;
 static uint8_t     brakeThrottleLock = 0;
 static MultipleTap MultipleTapBrake;    // define multiple tap functionality for the Brake pedal
 
 static uint16_t rate = RATE; // Adjustable rate to support multiple drive modes on startup
 
 /*
  * Brake interlock helper
  * - When `brakeActive` is true: cancel any throttle, lock throttle until
  *   the physical throttle returns to near-zero to avoid sudden re-acceleration.
  * - When `brakeThrottleLock` is set: keep throttle at zero until `rawThrottleCmd` small.
  */
-static void apply_brake_interlock(int16_t *throttleCommand, int16_t rawThrottleCmd, uint8_t brakeActive) {
+static void apply_brake_interlock(int16_t *throttleCommand, int16_t rawThrottleCmd, uint8_t brakeActive, uint8_t reverseRequested) {
   if (brakeActive) {
-    *throttleCommand = 0;
-    brakeThrottleLock = 1;
-    filteredBrakeCmd = BRAKE_MAX_LIMIT; // request full braking to stop quickly
+    // If brake is pressed, ensure we lock throttle on release, but do not
+    // overwrite the computed brake throttle (which applies braking torque).
+    // Only cancel an active reverse command to avoid conflicting inputs.
+    if (reverseRequested && *throttleCommand < 0) {
+      *throttleCommand = 0; // cancel reverse request while brake pressed
+    }
+    brakeThrottleLock = 1; // lock throttle until user releases throttle to zero
   } else if (brakeThrottleLock) {
+    // While locked, keep throttle at zero until physical throttle returns to near zero
     if (ABS(rawThrottleCmd) < 10) {
-      brakeThrottleLock = 0; // release lock only when throttle is near zero
+      brakeThrottleLock = 0; // release lock
       *throttleCommand = 0;
     } else {
-      *throttleCommand = 0; // keep throttle zero while locked
+      *throttleCommand = 0;
     }
   }
 }
 
 #ifdef MULTI_MODE_DRIVE
   static uint8_t drive_mode;
   static uint16_t max_speed;
 #endif
 
 
 int main(void) {
 
   HAL_Init();
   __HAL_RCC_AFIO_CLK_ENABLE();
   HAL_NVIC_SetPriorityGrouping(NVIC_PRIORITYGROUP_4);
   /* System interrupt init*/
   /* MemoryManagement_IRQn interrupt configuration */
   HAL_NVIC_SetPriority(MemoryManagement_IRQn, 0, 0);
   /* BusFault_IRQn interrupt configuration */
   HAL_NVIC_SetPriority(BusFault_IRQn, 0, 0);
@@ -382,41 +387,41 @@ int main(void) {
             if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
               filteredBrakeCmd -= BRAKE_RAMP_STEP;
             } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
               filteredBrakeCmd += BRAKE_RAMP_STEP;
             } else {
               filteredBrakeCmd = 0;
             }
           } else {
             if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
               filteredBrakeCmd -= BRAKE_RAMP_STEP;
             } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
               filteredBrakeCmd += BRAKE_RAMP_STEP;
             } else {
               filteredBrakeCmd = 0;
             }
             throttleCommand = (ABS(rawThrottleCmd) < 10) ? 0 : rawThrottleCmd;
           }
         }
 
         // Apply unified brake interlock for both forward and reverse
-        apply_brake_interlock(&throttleCommand, rawThrottleCmd, brakeActive);
+        apply_brake_interlock(&throttleCommand, rawThrottleCmd, brakeActive, reverseRequested);
 
         input1[inIdx].cmd = 0;
         input2[inIdx].cmd = throttleCommand;
       }
       #endif
 
       #ifdef VARIANT_SKATEBOARD
         if (input2[inIdx].cmd < 0) {                                // When Throttle is negative, it acts as brake. This condition is to make sure it goes to 0 as we reach standstill (to avoid Reverse driving) 
           if (speedAvg > 0) {                                       // Make sure the braking is opposite to the direction of motion
             input2[inIdx].cmd  = (int16_t)(( input2[inIdx].cmd * speedBlend) >> 15);
           } else {
             input2[inIdx].cmd  = (int16_t)((-input2[inIdx].cmd * speedBlend) >> 15);
           }
         }
       #endif
 
       // ####### LOW-PASS FILTER #######
       rateLimiter16(input1[inIdx].cmd, rate, &steerRateFixdt);
 
       {
```

## f05e431512c8 - 倒车分支的逻辑：倒车油门 同时踩刹车则计算并应用制动力（保持阻力感觉=GD32F103RCT6

- Author: Too large to fit in the margin <qgbcs@outlook.com>
- Date: 2026-06-29
- Diff:

```diff
commit f05e431512c89aed67fefa2bee7fd9c5d2c0cd71
Author: Too large to fit in the margin <qgbcs@outlook.com>
Date: 2026-06-29
Subject: 倒车分支的逻辑：倒车油门 同时踩刹车则计算并应用制动力（保持阻力感觉=GD32F103RCT6



diff --git a/Src/main.c b/Src/main.c
index db828ec..072c43b 100644
--- a/Src/main.c
+++ b/Src/main.c
@@ -310,41 +310,41 @@ int main(void) {
       int16_t motionDir = (speedAvg > 0) ? 1 : ((speedAvg < 0) ? -1 : 0);
 
       #ifdef VARIANT_HOVERCAR
       if (inIdx == CONTROL_ADC) {                                   // Convert brake pedal input into a smooth, direction-aware speed target before filtering.
         if (ABS(rawThrottleCmd) < 10) {
           rawThrottleCmd = 0;
         }
         brakePedalRaw = ABS(input1[inIdx].cmd);
         brakeActive = (brakePedalRaw > BRAKE_PEDAL_THRESHOLD);
         reverseRequested = (MultipleTapBrake.b_multipleTap && speedAvgAbs < 60) ? 1 : 0;
 
         int32_t speedFactor = 1000;
         if (speedAvgAbs < BRAKE_MIN_SPEED_RPM) {
           speedFactor = 0;
         } else if (speedAvgAbs < BRAKE_SMOOTH_ZONE_RPM) {
           speedFactor = ((int32_t)speedAvgAbs - BRAKE_MIN_SPEED_RPM) * 1000 /
                         (BRAKE_SMOOTH_ZONE_RPM - BRAKE_MIN_SPEED_RPM);
         }
 
         int16_t throttleInputMag = ABS(rawThrottleCmd);
-        if (reverseRequested && throttleInputMag > 10) {
+        if (reverseRequested && throttleInputMag > 10 && !brakeActive) {
           int16_t reverseMagnitude = (int16_t)CLAMP(throttleInputMag, 0, REVERSE_SPEED_LIMIT);
           filteredBrakeCmd = 0;
           throttleCommand = (int16_t)(-reverseMagnitude);
         } else {
           int16_t brakeMagnitude = 0;
           if (brakeActive) {
             int32_t pedalScaled = (int32_t)brakePedalRaw;
             if (speedAvgAbs < BRAKE_MIN_SPEED_RPM) {
               pedalScaled = (pedalScaled * 1000) / 1000;
             } else if (speedAvgAbs < BRAKE_SMOOTH_ZONE_RPM) {
               pedalScaled = (pedalScaled * speedFactor) / 1000;
             } else {
               pedalScaled = (pedalScaled * speedFactor) / 1000;
             }
             brakeMagnitude = (int16_t)CLAMP(pedalScaled, 0, BRAKE_MAX_LIMIT);
           }
 
           if (brakeActive) {
             brakeThrottleLock = 1;
             if (brakeMagnitude > 0) {
```

## 9dcbe69aa26b - md文档 倒车分支的逻辑：倒车油门 同时踩刹车则计算并应用制动力（保持阻力感觉=GD32F103RCT6

- Author: Too large to fit in the margin <qgbcs@outlook.com>
- Date: 2026-06-29
- Diff:

```diff
commit 9dcbe69aa26bf22c4324521645a5a3ca8c13f570
Author: Too large to fit in the margin <qgbcs@outlook.com>
Date: 2026-06-29
Subject: md文档 倒车分支的逻辑：倒车油门 同时踩刹车则计算并应用制动力（保持阻力感觉=GD32F103RCT6



diff --git a/Src/main.c b/Src/main.c
index 072c43b..67c3d6d 100644
--- a/Src/main.c
+++ b/Src/main.c
@@ -357,41 +357,45 @@ int main(void) {
                 filteredBrakeCmd = brakeMagnitude;
               }
             } else {
               if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
                 filteredBrakeCmd -= BRAKE_RAMP_STEP;
               } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
                 filteredBrakeCmd += BRAKE_RAMP_STEP;
               } else {
                 filteredBrakeCmd = 0;
               }
             }
 
             if (speedAvgAbs < BRAKE_SMOOTH_ZONE_RPM) {
               int32_t dampingCmd = ((int32_t)filteredBrakeCmd * (int32_t)ABS(speedAvg)) / BRAKE_SMOOTH_ZONE_RPM;
               throttleCommand = (speedAvg >= 0) ? (int16_t)(-dampingCmd) : (int16_t)(dampingCmd);
             } else if (speedAvg > 0) {
               throttleCommand = (int16_t)(-filteredBrakeCmd);
             } else if (speedAvg < 0) {
               throttleCommand = (int16_t)(filteredBrakeCmd);
             } else {
-              throttleCommand = 0;
+              // At exact standstill, apply a small static damping (not full dynamic brake)
+              // to provide resistance while avoiding a full-step reversal that would
+              // produce a knife-edge oscillation. Scale is small (200/1000 = 0.2).
+              const int32_t STATIC_DAMPING_SCALE = 200; // out of BRAKE_MAX_LIMIT
+              throttleCommand = (int16_t)(-(filteredBrakeCmd * STATIC_DAMPING_SCALE) / BRAKE_MAX_LIMIT);
             }
           } else if (brakeThrottleLock) {
             if (ABS(rawThrottleCmd) < 10) {
               brakeThrottleLock = 0;
               throttleCommand = 0;
             } else {
               throttleCommand = 0;
             }
 
             if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
               filteredBrakeCmd -= BRAKE_RAMP_STEP;
             } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
               filteredBrakeCmd += BRAKE_RAMP_STEP;
             } else {
               filteredBrakeCmd = 0;
             }
           } else {
             if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
               filteredBrakeCmd -= BRAKE_RAMP_STEP;
             } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
```

## 26e48387d01e - 倒车刹车 日志显示 br 和 fbc 非零，但 cL/cR 始终 0，说明制动命令并未进入最后的驱动=GD32F103RCT6

- Author: Too large to fit in the margin <qgbcs@outlook.com>
- Date: 2026-06-29
- Diff:

```diff
commit 26e48387d01e94329c33f03002c6e58dae7b8502
Author: Too large to fit in the margin <qgbcs@outlook.com>
Date: 2026-06-29
Subject: 倒车刹车 日志显示 br 和 fbc 非零，但 cL/cR 始终 0，说明制动命令并未进入最后的驱动=GD32F103RCT6



diff --git a/Src/main.c b/Src/main.c
index 67c3d6d..9dabdd3 100644
--- a/Src/main.c
+++ b/Src/main.c
@@ -136,43 +136,44 @@ static int16_t    speed;                // local variable for speed. -1000 to 10
   static int32_t  speedFixdt;           // local fixed-point variable for speed low-pass filter
 #endif
 
 static uint32_t    buzzerTimer_prev = 0;
 static uint32_t    inactivity_timeout_counter;
 static int16_t     filteredBrakeCmd = 0;
 static uint8_t     brakeThrottleLock = 0;
 static MultipleTap MultipleTapBrake;    // define multiple tap functionality for the Brake pedal
 
 static uint16_t rate = RATE; // Adjustable rate to support multiple drive modes on startup
 
 /*
  * Brake interlock helper
  * - When `brakeActive` is true: cancel any throttle, lock throttle until
  *   the physical throttle returns to near-zero to avoid sudden re-acceleration.
  * - When `brakeThrottleLock` is set: keep throttle at zero until `rawThrottleCmd` small.
  */
 static void apply_brake_interlock(int16_t *throttleCommand, int16_t rawThrottleCmd, uint8_t brakeActive, uint8_t reverseRequested) {
   if (brakeActive) {
     // If brake is pressed, ensure we lock throttle on release, but do not
-    // overwrite the computed brake throttle (which applies braking torque).
-    // Only cancel an active reverse command to avoid conflicting inputs.
-    if (reverseRequested && *throttleCommand < 0) {
+    // overwrite the computed brake torque command. Only cancel an active
+    // reverse drive request when the brake is not already generating braking
+    // torque.
+    if (reverseRequested && !brakeActive && *throttleCommand < 0) {
       *throttleCommand = 0; // cancel reverse request while brake pressed
     }
     brakeThrottleLock = 1; // lock throttle until user releases throttle to zero
   } else if (brakeThrottleLock) {
     // While locked, keep throttle at zero until physical throttle returns to near zero
     if (ABS(rawThrottleCmd) < 10) {
       brakeThrottleLock = 0; // release lock
       *throttleCommand = 0;
     } else {
       *throttleCommand = 0;
     }
   }
 }
 
 #ifdef MULTI_MODE_DRIVE
   static uint8_t drive_mode;
   static uint16_t max_speed;
 #endif
 
 
@@ -349,53 +350,55 @@ int main(void) {
             brakeThrottleLock = 1;
             if (brakeMagnitude > 0) {
               int32_t brakeError = (int32_t)brakeMagnitude - filteredBrakeCmd;
               if (brakeError > BRAKE_RAMP_STEP) {
                 filteredBrakeCmd += BRAKE_RAMP_STEP;
               } else if (brakeError < -BRAKE_RAMP_STEP) {
                 filteredBrakeCmd -= BRAKE_RAMP_STEP;
               } else {
                 filteredBrakeCmd = brakeMagnitude;
               }
             } else {
               if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
                 filteredBrakeCmd -= BRAKE_RAMP_STEP;
               } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
                 filteredBrakeCmd += BRAKE_RAMP_STEP;
               } else {
                 filteredBrakeCmd = 0;
               }
             }
 
-            if (speedAvgAbs < BRAKE_SMOOTH_ZONE_RPM) {
+            if (speedAvg == 0) {
+              // At exact standstill, apply a small static damping (not full dynamic brake)
+              // to provide resistance while avoiding a full-step reversal that would
+              // produce a knife-edge oscillation. Scale is small (200/1000 = 0.2).
+              const int32_t STATIC_DAMPING_SCALE = 200; // out of BRAKE_MAX_LIMIT
+              throttleCommand = (int16_t)(-(filteredBrakeCmd * STATIC_DAMPING_SCALE) / BRAKE_MAX_LIMIT);
+            } else if (speedAvgAbs < BRAKE_SMOOTH_ZONE_RPM) {
               int32_t dampingCmd = ((int32_t)filteredBrakeCmd * (int32_t)ABS(speedAvg)) / BRAKE_SMOOTH_ZONE_RPM;
               throttleCommand = (speedAvg >= 0) ? (int16_t)(-dampingCmd) : (int16_t)(dampingCmd);
             } else if (speedAvg > 0) {
               throttleCommand = (int16_t)(-filteredBrakeCmd);
             } else if (speedAvg < 0) {
               throttleCommand = (int16_t)(filteredBrakeCmd);
             } else {
-              // At exact standstill, apply a small static damping (not full dynamic brake)
-              // to provide resistance while avoiding a full-step reversal that would
-              // produce a knife-edge oscillation. Scale is small (200/1000 = 0.2).
-              const int32_t STATIC_DAMPING_SCALE = 200; // out of BRAKE_MAX_LIMIT
-              throttleCommand = (int16_t)(-(filteredBrakeCmd * STATIC_DAMPING_SCALE) / BRAKE_MAX_LIMIT);
+              throttleCommand = 0;
             }
           } else if (brakeThrottleLock) {
             if (ABS(rawThrottleCmd) < 10) {
               brakeThrottleLock = 0;
               throttleCommand = 0;
             } else {
               throttleCommand = 0;
             }
 
             if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
               filteredBrakeCmd -= BRAKE_RAMP_STEP;
             } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
               filteredBrakeCmd += BRAKE_RAMP_STEP;
             } else {
               filteredBrakeCmd = 0;
             }
           } else {
             if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
               filteredBrakeCmd -= BRAKE_RAMP_STEP;
             } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
```

## 7b2755483c7d - 没碰油门，轮子本身静止没有外力，多次按刹车，轮子居然蠕动了 =GD32F103RCT6

- Author: Too large to fit in the margin <qgbcs@outlook.com>
- Date: 2026-06-29
- Diff:

```diff
commit 7b2755483c7d91a14bbe7fa33bbaa4db57b24007
Author: Too large to fit in the margin <qgbcs@outlook.com>
Date: 2026-06-29
Subject: 没碰油门，轮子本身静止没有外力，多次按刹车，轮子居然蠕动了 =GD32F103RCT6



diff --git a/Src/main.c b/Src/main.c
index 9dabdd3..7e04371 100644
--- a/Src/main.c
+++ b/Src/main.c
@@ -135,55 +135,50 @@ static int16_t    speed;                // local variable for speed. -1000 to 10
   static int32_t  steerFixdt;           // local fixed-point variable for steering low-pass filter
   static int32_t  speedFixdt;           // local fixed-point variable for speed low-pass filter
 #endif
 
 static uint32_t    buzzerTimer_prev = 0;
 static uint32_t    inactivity_timeout_counter;
 static int16_t     filteredBrakeCmd = 0;
 static uint8_t     brakeThrottleLock = 0;
 static MultipleTap MultipleTapBrake;    // define multiple tap functionality for the Brake pedal
 
 static uint16_t rate = RATE; // Adjustable rate to support multiple drive modes on startup
 
 /*
  * Brake interlock helper
  * - When `brakeActive` is true: cancel any throttle, lock throttle until
  *   the physical throttle returns to near-zero to avoid sudden re-acceleration.
  * - When `brakeThrottleLock` is set: keep throttle at zero until `rawThrottleCmd` small.
  */
 static void apply_brake_interlock(int16_t *throttleCommand, int16_t rawThrottleCmd, uint8_t brakeActive, uint8_t reverseRequested) {
   if (brakeActive) {
-    // If brake is pressed, ensure we lock throttle on release, but do not
-    // overwrite the computed brake torque command. Only cancel an active
-    // reverse drive request when the brake is not already generating braking
-    // torque.
-    if (reverseRequested && !brakeActive && *throttleCommand < 0) {
-      *throttleCommand = 0; // cancel reverse request while brake pressed
-    }
-    brakeThrottleLock = 1; // lock throttle until user releases throttle to zero
-  } else if (brakeThrottleLock) {
-    // While locked, keep throttle at zero until physical throttle returns to near zero
+    // If brake is pressed, keep throttle locked until physical throttle returns
+    // to near zero. The brake path itself already generates the braking output.
+    brakeThrottleLock = 1;
+  }
+
+  if (brakeThrottleLock) {
     if (ABS(rawThrottleCmd) < 10) {
-      brakeThrottleLock = 0; // release lock
-      *throttleCommand = 0;
+      brakeThrottleLock = 0; // release lock when throttle is released
     } else {
-      *throttleCommand = 0;
+      *throttleCommand = 0; // prevent drive while lock is active
     }
   }
 }
 
 #ifdef MULTI_MODE_DRIVE
   static uint8_t drive_mode;
   static uint16_t max_speed;
 #endif
 
 
 int main(void) {
 
   HAL_Init();
   __HAL_RCC_AFIO_CLK_ENABLE();
   HAL_NVIC_SetPriorityGrouping(NVIC_PRIORITYGROUP_4);
   /* System interrupt init*/
   /* MemoryManagement_IRQn interrupt configuration */
   HAL_NVIC_SetPriority(MemoryManagement_IRQn, 0, 0);
   /* BusFault_IRQn interrupt configuration */
   HAL_NVIC_SetPriority(BusFault_IRQn, 0, 0);
@@ -350,46 +345,45 @@ int main(void) {
             brakeThrottleLock = 1;
             if (brakeMagnitude > 0) {
               int32_t brakeError = (int32_t)brakeMagnitude - filteredBrakeCmd;
               if (brakeError > BRAKE_RAMP_STEP) {
                 filteredBrakeCmd += BRAKE_RAMP_STEP;
               } else if (brakeError < -BRAKE_RAMP_STEP) {
                 filteredBrakeCmd -= BRAKE_RAMP_STEP;
               } else {
                 filteredBrakeCmd = brakeMagnitude;
               }
             } else {
               if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
                 filteredBrakeCmd -= BRAKE_RAMP_STEP;
               } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
                 filteredBrakeCmd += BRAKE_RAMP_STEP;
               } else {
                 filteredBrakeCmd = 0;
               }
             }
 
-            if (speedAvg == 0) {
-              // At exact standstill, apply a small static damping (not full dynamic brake)
-              // to provide resistance while avoiding a full-step reversal that would
-              // produce a knife-edge oscillation. Scale is small (200/1000 = 0.2).
-              const int32_t STATIC_DAMPING_SCALE = 200; // out of BRAKE_MAX_LIMIT
-              throttleCommand = (int16_t)(-(filteredBrakeCmd * STATIC_DAMPING_SCALE) / BRAKE_MAX_LIMIT);
+            if (speedAvgAbs <= BRAKE_MIN_SPEED_RPM) {
+              // At very low speed or stop, do not issue active brake drive torque.
+              // This avoids small sensor noise or control dithering causing wheel creep
+              // when the wheels are already essentially stationary.
+              throttleCommand = 0;
             } else if (speedAvgAbs < BRAKE_SMOOTH_ZONE_RPM) {
               int32_t dampingCmd = ((int32_t)filteredBrakeCmd * (int32_t)ABS(speedAvg)) / BRAKE_SMOOTH_ZONE_RPM;
               throttleCommand = (speedAvg >= 0) ? (int16_t)(-dampingCmd) : (int16_t)(dampingCmd);
             } else if (speedAvg > 0) {
               throttleCommand = (int16_t)(-filteredBrakeCmd);
             } else if (speedAvg < 0) {
               throttleCommand = (int16_t)(filteredBrakeCmd);
             } else {
               throttleCommand = 0;
             }
           } else if (brakeThrottleLock) {
             if (ABS(rawThrottleCmd) < 10) {
               brakeThrottleLock = 0;
               throttleCommand = 0;
             } else {
               throttleCommand = 0;
             }
 
             if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
               filteredBrakeCmd -= BRAKE_RAMP_STEP;
```

## 70c52d4d8868 - fix在倒车状态，半拧油门 ，两个轮子出现前后乱窜  而且倒车状态不是有限速吗，怎么速度飙到最大值 =GD32F103RCT6

- Author: Too large to fit in the margin <qgbcs@outlook.com>
- Date: 2026-06-29
- Diff:

```diff
commit 70c52d4d8868aa2c484739db39d12367a8c4d309
Author: Too large to fit in the margin <qgbcs@outlook.com>
Date: 2026-06-29
Subject: fix在倒车状态，半拧油门 ，两个轮子出现前后乱窜  而且倒车状态不是有限速吗，怎么速度飙到最大值 =GD32F103RCT6



diff --git a/Src/main.c b/Src/main.c
index 7e04371..17143a2 100644
--- a/Src/main.c
+++ b/Src/main.c
@@ -123,40 +123,41 @@ static uint8_t sideboard_leds_R;
   static uint16_t distance;
   static float    steering;
   static int      distanceErr;  
   static int      lastDistance = 0;
   static uint16_t transpotter_counter = 0;
 #endif
 
 static int16_t    speed;                // local variable for speed. -1000 to 1000
 #ifndef VARIANT_TRANSPOTTER
   static int16_t  steer;                // local variable for steering. -1000 to 1000
   static int16_t  steerRateFixdt;       // local fixed-point variable for steering rate limiter
   static int16_t  speedRateFixdt;       // local fixed-point variable for speed rate limiter
   static int32_t  steerFixdt;           // local fixed-point variable for steering low-pass filter
   static int32_t  speedFixdt;           // local fixed-point variable for speed low-pass filter
 #endif
 
 static uint32_t    buzzerTimer_prev = 0;
 static uint32_t    inactivity_timeout_counter;
 static int16_t     filteredBrakeCmd = 0;
 static uint8_t     brakeThrottleLock = 0;
+static uint8_t     reverseCommandActive = 0;
 static MultipleTap MultipleTapBrake;    // define multiple tap functionality for the Brake pedal
 
 static uint16_t rate = RATE; // Adjustable rate to support multiple drive modes on startup
 
 /*
  * Brake interlock helper
  * - When `brakeActive` is true: cancel any throttle, lock throttle until
  *   the physical throttle returns to near-zero to avoid sudden re-acceleration.
  * - When `brakeThrottleLock` is set: keep throttle at zero until `rawThrottleCmd` small.
  */
 static void apply_brake_interlock(int16_t *throttleCommand, int16_t rawThrottleCmd, uint8_t brakeActive, uint8_t reverseRequested) {
   if (brakeActive) {
     // If brake is pressed, keep throttle locked until physical throttle returns
     // to near zero. The brake path itself already generates the braking output.
     brakeThrottleLock = 1;
   }
 
   if (brakeThrottleLock) {
     if (ABS(rawThrottleCmd) < 10) {
       brakeThrottleLock = 0; // release lock when throttle is released
@@ -307,44 +308,55 @@ int main(void) {
 
       #ifdef VARIANT_HOVERCAR
       if (inIdx == CONTROL_ADC) {                                   // Convert brake pedal input into a smooth, direction-aware speed target before filtering.
         if (ABS(rawThrottleCmd) < 10) {
           rawThrottleCmd = 0;
         }
         brakePedalRaw = ABS(input1[inIdx].cmd);
         brakeActive = (brakePedalRaw > BRAKE_PEDAL_THRESHOLD);
         reverseRequested = (MultipleTapBrake.b_multipleTap && speedAvgAbs < 60) ? 1 : 0;
 
         int32_t speedFactor = 1000;
         if (speedAvgAbs < BRAKE_MIN_SPEED_RPM) {
           speedFactor = 0;
         } else if (speedAvgAbs < BRAKE_SMOOTH_ZONE_RPM) {
           speedFactor = ((int32_t)speedAvgAbs - BRAKE_MIN_SPEED_RPM) * 1000 /
                         (BRAKE_SMOOTH_ZONE_RPM - BRAKE_MIN_SPEED_RPM);
         }
 
         int16_t throttleInputMag = ABS(rawThrottleCmd);
         if (reverseRequested && throttleInputMag > 10 && !brakeActive) {
-          int16_t reverseMagnitude = (int16_t)CLAMP(throttleInputMag, 0, REVERSE_SPEED_LIMIT);
-          filteredBrakeCmd = 0;
-          throttleCommand = (int16_t)(-reverseMagnitude);
+          if (speedAvgAbs > 30 || speedAvg > 20) {
+            reverseCommandActive = 0;
+            filteredBrakeCmd = 0;
+            throttleCommand = 0;
+          } else {
+            reverseCommandActive = 1;
+            int16_t reverseMagnitude = (int16_t)CLAMP(throttleInputMag, 0, REVERSE_SPEED_LIMIT);
+            filteredBrakeCmd = 0;
+            throttleCommand = (int16_t)(-reverseMagnitude);
+          }
         } else {
+          if (reverseCommandActive && (brakeActive || ABS(rawThrottleCmd) < 10 || speedAvgAbs > 30 || speedAvg > 20)) {
+            reverseCommandActive = 0;
+          }
+
           int16_t brakeMagnitude = 0;
           if (brakeActive) {
             int32_t pedalScaled = (int32_t)brakePedalRaw;
             if (speedAvgAbs < BRAKE_MIN_SPEED_RPM) {
               pedalScaled = (pedalScaled * 1000) / 1000;
             } else if (speedAvgAbs < BRAKE_SMOOTH_ZONE_RPM) {
               pedalScaled = (pedalScaled * speedFactor) / 1000;
             } else {
               pedalScaled = (pedalScaled * speedFactor) / 1000;
             }
             brakeMagnitude = (int16_t)CLAMP(pedalScaled, 0, BRAKE_MAX_LIMIT);
           }
 
           if (brakeActive) {
             brakeThrottleLock = 1;
             if (brakeMagnitude > 0) {
               int32_t brakeError = (int32_t)brakeMagnitude - filteredBrakeCmd;
               if (brakeError > BRAKE_RAMP_STEP) {
                 filteredBrakeCmd += BRAKE_RAMP_STEP;
               } else if (brakeError < -BRAKE_RAMP_STEP) {
@@ -390,40 +402,44 @@ int main(void) {
             } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
               filteredBrakeCmd += BRAKE_RAMP_STEP;
             } else {
               filteredBrakeCmd = 0;
             }
           } else {
             if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
               filteredBrakeCmd -= BRAKE_RAMP_STEP;
             } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
               filteredBrakeCmd += BRAKE_RAMP_STEP;
             } else {
               filteredBrakeCmd = 0;
             }
             throttleCommand = (ABS(rawThrottleCmd) < 10) ? 0 : rawThrottleCmd;
           }
         }
 
         // Apply unified brake interlock for both forward and reverse
         apply_brake_interlock(&throttleCommand, rawThrottleCmd, brakeActive, reverseRequested);
 
+        if (throttleCommand < 0) {
+          throttleCommand = (int16_t)MAX(throttleCommand, -REVERSE_SPEED_LIMIT);
+        }
+
         input1[inIdx].cmd = 0;
         input2[inIdx].cmd = throttleCommand;
       }
       #endif
 
       #ifdef VARIANT_SKATEBOARD
         if (input2[inIdx].cmd < 0) {                                // When Throttle is negative, it acts as brake. This condition is to make sure it goes to 0 as we reach standstill (to avoid Reverse driving) 
           if (speedAvg > 0) {                                       // Make sure the braking is opposite to the direction of motion
             input2[inIdx].cmd  = (int16_t)(( input2[inIdx].cmd * speedBlend) >> 15);
           } else {
             input2[inIdx].cmd  = (int16_t)((-input2[inIdx].cmd * speedBlend) >> 15);
           }
         }
       #endif
 
       // ####### LOW-PASS FILTER #######
       rateLimiter16(input1[inIdx].cmd, rate, &steerRateFixdt);
 
       {
         int16_t throttleRate = THROTTLE_ACCEL_RATE;
```

## 0876f691fbec - 油门一直增加 ，没碰刹车，半路却突然断了=GD32F103RCT6

- Author: Too large to fit in the margin <qgbcs@outlook.com>
- Date: 2026-06-29
- Diff:

```diff
commit 0876f691fbec4e46f1043e57a2f0c0254b32c6b2
Author: Too large to fit in the margin <qgbcs@outlook.com>
Date: 2026-06-29
Subject: 油门一直增加 ，没碰刹车，半路却突然断了=GD32F103RCT6



diff --git a/Src/main.c b/Src/main.c
index 17143a2..428b0a8 100644
--- a/Src/main.c
+++ b/Src/main.c
@@ -136,42 +136,40 @@ static int16_t    speed;                // local variable for speed. -1000 to 10
   static int32_t  speedFixdt;           // local fixed-point variable for speed low-pass filter
 #endif
 
 static uint32_t    buzzerTimer_prev = 0;
 static uint32_t    inactivity_timeout_counter;
 static int16_t     filteredBrakeCmd = 0;
 static uint8_t     brakeThrottleLock = 0;
 static uint8_t     reverseCommandActive = 0;
 static MultipleTap MultipleTapBrake;    // define multiple tap functionality for the Brake pedal
 
 static uint16_t rate = RATE; // Adjustable rate to support multiple drive modes on startup
 
 /*
  * Brake interlock helper
  * - When `brakeActive` is true: cancel any throttle, lock throttle until
  *   the physical throttle returns to near-zero to avoid sudden re-acceleration.
  * - When `brakeThrottleLock` is set: keep throttle at zero until `rawThrottleCmd` small.
  */
 static void apply_brake_interlock(int16_t *throttleCommand, int16_t rawThrottleCmd, uint8_t brakeActive, uint8_t reverseRequested) {
   if (brakeActive) {
-    // If brake is pressed, keep throttle locked until physical throttle returns
-    // to near zero. The brake path itself already generates the braking output.
     brakeThrottleLock = 1;
   }
 
   if (brakeThrottleLock) {
     if (ABS(rawThrottleCmd) < 10) {
       brakeThrottleLock = 0; // release lock when throttle is released
     } else {
       *throttleCommand = 0; // prevent drive while lock is active
     }
   }
 }
 
 #ifdef MULTI_MODE_DRIVE
   static uint8_t drive_mode;
   static uint16_t max_speed;
 #endif
 
 
 int main(void) {
```

## 2c45a76e4159 - 油门一直增加 ，没碰刹车，半路却突然断了=GD32F103RCT6

- Author: Too large to fit in the margin <qgbcs@outlook.com>
- Date: 2026-06-29
- Diff:

```diff
commit 2c45a76e4159f15274af83f886a1a6efbb18c080
Author: Too large to fit in the margin <qgbcs@outlook.com>
Date: 2026-06-29
Subject: 油门一直增加 ，没碰刹车，半路却突然断了=GD32F103RCT6



diff --git a/Src/main.c b/Src/main.c
index 428b0a8..50ec03e 100644
--- a/Src/main.c
+++ b/Src/main.c
@@ -122,66 +122,45 @@ static uint8_t sideboard_leds_R;
   static uint8_t  checkRemote = 0;
   static uint16_t distance;
   static float    steering;
   static int      distanceErr;  
   static int      lastDistance = 0;
   static uint16_t transpotter_counter = 0;
 #endif
 
 static int16_t    speed;                // local variable for speed. -1000 to 1000
 #ifndef VARIANT_TRANSPOTTER
   static int16_t  steer;                // local variable for steering. -1000 to 1000
   static int16_t  steerRateFixdt;       // local fixed-point variable for steering rate limiter
   static int16_t  speedRateFixdt;       // local fixed-point variable for speed rate limiter
   static int32_t  steerFixdt;           // local fixed-point variable for steering low-pass filter
   static int32_t  speedFixdt;           // local fixed-point variable for speed low-pass filter
 #endif
 
 static uint32_t    buzzerTimer_prev = 0;
 static uint32_t    inactivity_timeout_counter;
 static int16_t     filteredBrakeCmd = 0;
-static uint8_t     brakeThrottleLock = 0;
 static uint8_t     reverseCommandActive = 0;
 static MultipleTap MultipleTapBrake;    // define multiple tap functionality for the Brake pedal
 
 static uint16_t rate = RATE; // Adjustable rate to support multiple drive modes on startup
 
-/*
- * Brake interlock helper
- * - When `brakeActive` is true: cancel any throttle, lock throttle until
- *   the physical throttle returns to near-zero to avoid sudden re-acceleration.
- * - When `brakeThrottleLock` is set: keep throttle at zero until `rawThrottleCmd` small.
- */
-static void apply_brake_interlock(int16_t *throttleCommand, int16_t rawThrottleCmd, uint8_t brakeActive, uint8_t reverseRequested) {
-  if (brakeActive) {
-    brakeThrottleLock = 1;
-  }
-
-  if (brakeThrottleLock) {
-    if (ABS(rawThrottleCmd) < 10) {
-      brakeThrottleLock = 0; // release lock when throttle is released
-    } else {
-      *throttleCommand = 0; // prevent drive while lock is active
-    }
-  }
-}
-
 #ifdef MULTI_MODE_DRIVE
   static uint8_t drive_mode;
   static uint16_t max_speed;
 #endif
 
 
 int main(void) {
 
   HAL_Init();
   __HAL_RCC_AFIO_CLK_ENABLE();
   HAL_NVIC_SetPriorityGrouping(NVIC_PRIORITYGROUP_4);
   /* System interrupt init*/
   /* MemoryManagement_IRQn interrupt configuration */
   HAL_NVIC_SetPriority(MemoryManagement_IRQn, 0, 0);
   /* BusFault_IRQn interrupt configuration */
   HAL_NVIC_SetPriority(BusFault_IRQn, 0, 0);
   /* UsageFault_IRQn interrupt configuration */
   HAL_NVIC_SetPriority(UsageFault_IRQn, 0, 0);
   /* SVCall_IRQn interrupt configuration */
   HAL_NVIC_SetPriority(SVCall_IRQn, 0, 0);
@@ -335,105 +314,86 @@ int main(void) {
           }
         } else {
           if (reverseCommandActive && (brakeActive || ABS(rawThrottleCmd) < 10 || speedAvgAbs > 30 || speedAvg > 20)) {
             reverseCommandActive = 0;
           }
 
           int16_t brakeMagnitude = 0;
           if (brakeActive) {
             int32_t pedalScaled = (int32_t)brakePedalRaw;
             if (speedAvgAbs < BRAKE_MIN_SPEED_RPM) {
               pedalScaled = (pedalScaled * 1000) / 1000;
             } else if (speedAvgAbs < BRAKE_SMOOTH_ZONE_RPM) {
               pedalScaled = (pedalScaled * speedFactor) / 1000;
             } else {
               pedalScaled = (pedalScaled * speedFactor) / 1000;
             }
             brakeMagnitude = (int16_t)CLAMP(pedalScaled, 0, BRAKE_MAX_LIMIT);
           }
 
           if (brakeActive) {
-            brakeThrottleLock = 1;
             if (brakeMagnitude > 0) {
               int32_t brakeError = (int32_t)brakeMagnitude - filteredBrakeCmd;
               if (brakeError > BRAKE_RAMP_STEP) {
                 filteredBrakeCmd += BRAKE_RAMP_STEP;
               } else if (brakeError < -BRAKE_RAMP_STEP) {
                 filteredBrakeCmd -= BRAKE_RAMP_STEP;
               } else {
                 filteredBrakeCmd = brakeMagnitude;
               }
             } else {
               if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
                 filteredBrakeCmd -= BRAKE_RAMP_STEP;
               } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
                 filteredBrakeCmd += BRAKE_RAMP_STEP;
               } else {
                 filteredBrakeCmd = 0;
               }
             }
 
             if (speedAvgAbs <= BRAKE_MIN_SPEED_RPM) {
               // At very low speed or stop, do not issue active brake drive torque.
               // This avoids small sensor noise or control dithering causing wheel creep
               // when the wheels are already essentially stationary.
               throttleCommand = 0;
             } else if (speedAvgAbs < BRAKE_SMOOTH_ZONE_RPM) {
               int32_t dampingCmd = ((int32_t)filteredBrakeCmd * (int32_t)ABS(speedAvg)) / BRAKE_SMOOTH_ZONE_RPM;
               throttleCommand = (speedAvg >= 0) ? (int16_t)(-dampingCmd) : (int16_t)(dampingCmd);
             } else if (speedAvg > 0) {
               throttleCommand = (int16_t)(-filteredBrakeCmd);
             } else if (speedAvg < 0) {
               throttleCommand = (int16_t)(filteredBrakeCmd);
             } else {
               throttleCommand = 0;
             }
-          } else if (brakeThrottleLock) {
-            if (ABS(rawThrottleCmd) < 10) {
-              brakeThrottleLock = 0;
-              throttleCommand = 0;
-            } else {
-              throttleCommand = 0;
-            }
-
-            if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
-              filteredBrakeCmd -= BRAKE_RAMP_STEP;
-            } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
-              filteredBrakeCmd += BRAKE_RAMP_STEP;
-            } else {
-              filteredBrakeCmd = 0;
-            }
           } else {
             if (filteredBrakeCmd > BRAKE_RAMP_STEP) {
               filteredBrakeCmd -= BRAKE_RAMP_STEP;
             } else if (filteredBrakeCmd < -BRAKE_RAMP_STEP) {
               filteredBrakeCmd += BRAKE_RAMP_STEP;
             } else {
               filteredBrakeCmd = 0;
             }
             throttleCommand = (ABS(rawThrottleCmd) < 10) ? 0 : rawThrottleCmd;
           }
         }
 
-        // Apply unified brake interlock for both forward and reverse
-        apply_brake_interlock(&throttleCommand, rawThrottleCmd, brakeActive, reverseRequested);
-
         if (throttleCommand < 0) {
           throttleCommand = (int16_t)MAX(throttleCommand, -REVERSE_SPEED_LIMIT);
         }
 
         input1[inIdx].cmd = 0;
         input2[inIdx].cmd = throttleCommand;
       }
       #endif
 
       #ifdef VARIANT_SKATEBOARD
         if (input2[inIdx].cmd < 0) {                                // When Throttle is negative, it acts as brake. This condition is to make sure it goes to 0 as we reach standstill (to avoid Reverse driving) 
           if (speedAvg > 0) {                                       // Make sure the braking is opposite to the direction of motion
             input2[inIdx].cmd  = (int16_t)(( input2[inIdx].cmd * speedBlend) >> 15);
           } else {
             input2[inIdx].cmd  = (int16_t)((-input2[inIdx].cmd * speedBlend) >> 15);
           }
         }
       #endif
 
       // ####### LOW-PASS FILTER #######
```
