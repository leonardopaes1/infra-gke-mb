resource "google_monitoring_notification_channel" "email_channel" {
  display_name = "Default Email Notifications"
  type         = "email"

  labels = {
    email_address = var.alert_email_address
  }
}

resource "google_monitoring_alert_policy" "pod_restart_alert" {
  display_name = "Pod Restart - More than 3 restarts in 5min"
  combiner     = "OR"

  conditions {
    display_name = "Container restart count"
    condition_threshold {
      filter          = "metric.type=\"kubernetes.io/container/restart_count\" resource.type=\"k8s_container\" resource.labels.namespace_name = \"prod\""
      comparison      = "COMPARISON_GT"
      threshold_value = 3
      duration        = "300s"

      aggregations {
        alignment_period   = "300s"
        per_series_aligner = "ALIGN_RATE"
      }
    }
  }

  notification_channels = [google_monitoring_notification_channel.email_channel.id]

  alert_strategy {
    auto_close = "3600s"
  }
}


