# ===================================================================================
# VARIABEL UNTUK LINGKUNGAN DEVELOPMENT
# ===================================================================================

environment = "d"

# --- Konfigurasi Jaringan ---
# PASTIKAN JUMLAH ITEM DI 3 LIST DI BAWAH INI SAMA (contoh ini: 3 item)
# Ganti dengan AZ yang valid di region Anda.
availability_zones = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
private_subnets    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
public_subnets     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]