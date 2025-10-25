package servlets;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import utils.Conexion;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String rol = request.getParameter("rol");

        System.out.println("Intento de login -> Usuario: " + username + " | Rol: " + rol);

        try (Connection conn = Conexion.getConnection()) {
            String sql = "SELECT * FROM usuarios WHERE username=? AND password_hash=? AND rol=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, rol);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("rol", rol);
                    session.setAttribute("usuario_id", rs.getInt("id"));


                switch (rol) {
                    case "admin":
                        response.sendRedirect("admin.jsp");
                        break;
                    case "sereno":
                        response.sendRedirect("sereno.jsp");
                        break;
                    case "vecino":
                        response.sendRedirect("vecino.jsp");
                        break;
                    default:
                        response.sendRedirect("login.jsp?error=rol");
                }
            } else {
                System.out.println("❌ Credenciales inválidas");
                response.sendRedirect("login.jsp?error=1");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=db");
        }
    }
}
