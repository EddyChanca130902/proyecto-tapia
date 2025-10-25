package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    private static final String URL = "jdbc:mysql://localhost:3306/infrareport?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root"; // cambia si tu usuario MySQL es diferente
    private static final String PASSWORD = "admin"; // agrega tu contraseña si tienes

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("✅ Driver MySQL cargado correctamente.");
        } catch (ClassNotFoundException e) {
            System.err.println("❌ Error al cargar el driver MySQL: " + e.getMessage());
        }
    }

    public static Connection getConnection() {
        Connection connection = null;
        try {
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✅ Conexión exitosa a la base de datos.");
        } catch (SQLException e) {
            System.err.println("❌ Error al conectar a la BD: " + e.getMessage());
        }
        return connection;
    }
}
