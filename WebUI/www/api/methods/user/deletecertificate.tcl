##
# User.deleteCertificate
# Löscht ein vorhandenes Zertifikat (server.pem) unter /etc/config
#
# Parameter:
#   keine
#
# Rückgabewert: true

catch {file delete /etc/config/server.pem}

jsonrpc_response true