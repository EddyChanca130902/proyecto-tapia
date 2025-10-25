package utils;

import java.sql.Connection;

public class TestConexion {
    public static void main(String[] args) {
        Connection cn = Conexion.getConnection();
        if (cn != null) {
            System.out.println("🎉 Conectado correctamente a MySQL");
        } else {
            System.out.println("🚫 No se pudo conectar a MySQL");
        }
    }
}
