resource "google_compute_firewall" "eth_rules" {
  name        = "gcp-test-eth-rules"
  network     = "default"
  description = "Allow traffic to eth nodes"

  allow {
    protocol = "tcp"
    ports    = ["31000", "30303"]
  }

  allow {
    protocol = "udp"
    ports    = ["31000", "30303"]
  }

  source_ranges = ["0.0.0.0/0"]
}
