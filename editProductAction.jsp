<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="dao.ProductDAO, bean.ProductBean, java.sql.*, javax.servlet.*, javax.servlet.http.*"%>

<%
    // Get the product data from the form
    String productId = request.getParameter("productId");
    String productName = request.getParameter("productName");
    String category = request.getParameter("category");
    String price = request.getParameter("price");
    String stock = request.getParameter("stock");
    String description = request.getParameter("description");

    // Get the current product details from the database
    ProductDAO productDAO = new ProductDAO();
    ProductBean product = null;

    try {
        // Check if price is not null or empty, and then parse it to double
        double parsedPrice = 0;
        if (price != null && !price.trim().isEmpty()) {
            parsedPrice = Double.parseDouble(price);
        } else {
            out.println("Price is required and cannot be empty.");
            return;  // Stop execution if price is missing
        }

        // Create a ProductBean object to update the product (no image update)
        product = new ProductBean(
            Integer.parseInt(productId),
            productName,
            category,  // assuming category is passed as categoryId (you might need to adjust based on actual implementation)
            parsedPrice,
            stock,
            description,
            null // Do not update image, set as null
        );

        // Call DAO to update the product in the database
        boolean updated = productDAO.updateProduct(product);

        if (updated) {
            response.sendRedirect("productManage.jsp?message=Product updated successfully.");
        } else {
            out.println("Error updating product.");
        }

    } catch (SQLException e) {
        out.println("Error updating product: " + e.getMessage());
    } catch (NumberFormatException e) {
        out.println("Invalid price format: " + e.getMessage());
    }
%>
