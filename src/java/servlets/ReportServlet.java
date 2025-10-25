package servlets;

import java.io.File;
import java.util.Date;
import java.text.SimpleDateFormat;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.IOException;


@WebServlet("/ReportServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class ReportServlet extends HttpServlet {
    
    private static final String UPLOAD_DIR = "uploads";
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Verificar sesión
        HttpSession session = request.getSession(false);
        if (session == null || !"sereno".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Obtener parámetros del formulario
        String categoria = request.getParameter("categoria");
        String lugar = request.getParameter("lugar");
        String descripcion = request.getParameter("descripcion");
        String urgente = request.getParameter("urgente");
        
        // Generar ID único para el reporte
        SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");
        String dateStr = sdf.format(new Date());
        String reportId = "RPT-" + dateStr + "-" + String.format("%03d", (int)(Math.random() * 1000));
        
        // Manejar subida de archivo
        String fileName = null;
        Part filePart = request.getPart("foto");
        if (filePart != null && filePart.getSize() > 0) {
            fileName = extractFileName(filePart);
            if (fileName != null && !fileName.isEmpty()) {
                // Crear directorio de uploads si no existe
                String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }
                
                // Guardar archivo
                String filePath = uploadPath + File.separator + reportId + "_" + fileName;
                filePart.write(filePath);
            }
        }
        
        // Aquí normalmente guardarías en base de datos
        // Por ahora, solo redirigimos con éxito
        
        // Redirigir al panel del sereno con mensaje de éxito
        response.sendRedirect("sereno.jsp?success=1&reportId=" + reportId);
    }
    
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }
}