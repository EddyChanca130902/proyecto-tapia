package servlets;

import java.io.IOException;
import java.sql.*;
import utils.Conexion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CategoriaServlet")
public class CategoriaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("create".equals(action)) {
            crearCategoria(request, response);
        } else if ("update".equals(action)) {
            actualizarCategoria(request, response);
        } else if ("delete".equals(action)) {
            eliminarCategoria(request, response);
        } else if ("permanentDelete".equals(action)) {
            eliminarPermanentemente(request, response);
        }
    }

    // CREATE
    private void crearCategoria(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = Conexion.getConnection();
            
            String sql = "INSERT INTO categoria (nombre, descripcion) VALUES (?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, nombre);
            ps.setString(2, descripcion);
            
            int rows = ps.executeUpdate();
            
            if (rows > 0) {
                response.sendRedirect("admin.jsp?section=categorias&success=Categoría creada exitosamente");
            } else {
                response.sendRedirect("admin.jsp?section=categorias&error=No se pudo crear la categoría");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin.jsp?section=categorias&error=Error de base de datos: " + e.getMessage());
        } finally {
            try {
                if (ps != null) ps.close();
                Conexion.close(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // UPDATE
    private void actualizarCategoria(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int idCategoria = Integer.parseInt(request.getParameter("id_categoria"));
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = Conexion.getConnection();
            
            String sql = "UPDATE categoria SET nombre=?, descripcion=? WHERE id_categoria=?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, nombre);
            ps.setString(2, descripcion);
            ps.setInt(3, idCategoria);
            
            int rows = ps.executeUpdate();
            
            if (rows > 0) {
                response.sendRedirect("admin.jsp?section=categorias&success=Categoría actualizada exitosamente");
            } else {
                response.sendRedirect("admin.jsp?section=categorias&error=No se pudo actualizar");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin.jsp?section=categorias&error=Error de base de datos: " + e.getMessage());
        } finally {
            try {
                if (ps != null) ps.close();
                Conexion.close(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // DELETE LÓGICO (desactivar)
    private void eliminarCategoria(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int idCategoria = Integer.parseInt(request.getParameter("id_categoria"));
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = Conexion.getConnection();
            
            String sql = "UPDATE categoria SET activo = 0 WHERE id_categoria = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, idCategoria);
            
            int rows = ps.executeUpdate();
            
            if (rows > 0) {
                response.sendRedirect("admin.jsp?section=categorias&success=Categoría desactivada exitosamente");
            } else {
                response.sendRedirect("admin.jsp?section=categorias&error=No se pudo desactivar");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin.jsp?section=categorias&error=Error de base de datos: " + e.getMessage());
        } finally {
            try {
                if (ps != null) ps.close();
                Conexion.close(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // DELETE PERMANENTE (eliminar de la base de datos)
    private void eliminarPermanentemente(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int idCategoria = Integer.parseInt(request.getParameter("id_categoria"));
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = Conexion.getConnection();
            
            // Primero verificar si hay reportes usando esta categoría
            String checkSql = "SELECT COUNT(*) FROM reportes WHERE id_categoria = ?";
            ps = conn.prepareStatement(checkSql);
            ps.setInt(1, idCategoria);
            rs = ps.executeQuery();
            
            int count = 0;
            if (rs.next()) {
                count = rs.getInt(1);
            }
            rs.close();
            ps.close();
            
            if (count > 0) {
                response.sendRedirect("admin.jsp?section=categorias&error=No se puede eliminar. Hay " + count + " reporte(s) usando esta categoría");
                return;
            }
            
            // Si no hay reportes, eliminar la categoría
            String sql = "DELETE FROM categoria WHERE id_categoria = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, idCategoria);
            
            int rows = ps.executeUpdate();
            
            if (rows > 0) {
                response.sendRedirect("admin.jsp?section=categorias&success=Categoría eliminada permanentemente de la base de datos");
            } else {
                response.sendRedirect("admin.jsp?section=categorias&error=No se pudo eliminar la categoría");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin.jsp?section=categorias&error=Error de base de datos: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                Conexion.close(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
