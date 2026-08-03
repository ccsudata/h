import unittest


def read_command_old(serial_active, in_idx, adc_cmd, serial_cmd):
    # Simulate the current logic order: sample before switching input source.
    cmd = adc_cmd if in_idx == 0 else serial_cmd
    if serial_active:
        in_idx = 1
    return in_idx, cmd


def read_command_new(serial_active, in_idx, adc_cmd, serial_cmd):
    # Fixed logic: switch source first, then sample with the selected source.
    if serial_active:
        in_idx = 1
    cmd = adc_cmd if in_idx == 0 else serial_cmd
    return in_idx, cmd


class SerialInputSelectionTests(unittest.TestCase):
    def test_old_order_uses_stale_adc_value(self):
        in_idx, cmd = read_command_old(True, 0, 0, 888)
        self.assertEqual(in_idx, 1)
        self.assertEqual(cmd, 0)

    def test_fixed_order_uses_serial_value_in_same_cycle(self):
        in_idx, cmd = read_command_new(True, 0, 0, 888)
        self.assertEqual(in_idx, 1)
        self.assertEqual(cmd, 888)


if __name__ == "__main__":
    unittest.main()
