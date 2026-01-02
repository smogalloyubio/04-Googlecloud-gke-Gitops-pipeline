resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  count               = length(var.instance_ids)

  alarm_name          = "${var.org}-${var.environment}-${var.region}-cpu-alarm-${format("%02d", count.index + 1)}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2

  metric_name = "CPUUtilization"
  namespace   = "AWS/EC2"
  statistic   = "Average"
  period      = 300
  threshold   = var.cpu_threshold

  dimensions = {
    InstanceId = var.instance_ids[count.index]
  }

  alarm_description = "High CPU utilization detected"
}
 