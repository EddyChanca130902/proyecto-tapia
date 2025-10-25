package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    
    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        
        // Validación simple de credenciales
        boolean isValid = false;
        String redirectPage = "";
        
        if ("admin".equals(username) && "123".equals(password) && "admin".equals(role)) {
            isValid = true;
            redirectPage = "admin.jsp";
        } else if ("sereno".equals(username) && "123".equals(password) && "sereno".equals(role)) {
            isValid = true;
            redirectPage = "sereno.jsp";
        } else if ("vecino".equals(username) && "123".equals(password) && "vecino".equals(role)) {
            isValid = true;
            redirectPage = "vecino.jsp";
        }
        
        if (isValid) {
            // Crear sesión
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("userRole", role);
            
            // Redirigir al panel correspondiente
            response.sendRedirect(redirectPage);
        } else {
            // Credenciales incorrectas, redirigir al login con error
            response.sendRedirect("login.jsp?error=1");
        }
    }
}