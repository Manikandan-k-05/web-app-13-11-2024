/*
 * package dao; import java.sql.Connection; import java.sql.PreparedStatement;
 * import java.sql.ResultSet; import java.sql.SQLException; import
 * java.util.ArrayList; import java.util.List;
 * 
 * import bean.CategoryBean; import db.DBconnection; public class CategoryDAO {
 * 
 * public boolean insertCategory(CategoryBean category) throws SQLException {
 * String sql = "INSERT INTO category (categoryName) VALUES (?)";
 * 
 * try (Connection conn = DBconnection.getConnection(); PreparedStatement stmt =
 * conn.prepareStatement(sql)) {
 * 
 * stmt.setString(1, category.getCategoryName()); int affectedRows =
 * stmt.executeUpdate();
 * 
 * return affectedRows > 0; // Return true if insertion is successful } catch
 * (SQLException e) { System.out.println("Error while inserting category: " +
 * e.getMessage()); return false; // Return false in case of an error } } public
 * List<CategoryBean> getCategories() throws SQLException { List<CategoryBean>
 * categories = new ArrayList<>(); String sql = "SELECT * FROM category";
 * 
 * try (Connection conn = DBconnection.getConnection(); PreparedStatement stmt =
 * conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
 * 
 * while (rs.next()) { CategoryBean category = new
 * CategoryBean(rs.getInt("categoryId"), rs.getString("categoryName"));
 * categories.add(category); } } return categories; } }
 */




package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.CategoryBean;
import bean.ProductBean;
import db.DBconnection;

public class CategoryDAO {

    // Insert a new category into the database
	public boolean insertProducts(ProductBean product) throws SQLException {
	    String sql = "INSERT INTO product (productName, categoryId, price, stock, description, productImage) VALUES (?, ?, ?, ?, ?, ?)";
	    try (Connection conn = DBconnection.getConnection(); 
	         PreparedStatement stmt = conn.prepareStatement(sql)) {

	        // First, fetch the categoryId from the category table based on the category name
	        int categoryId = getCategoryIdByName(product.getCategory(), conn);

	        if (categoryId == -1) { // If category does not exist, return false
	            System.out.println("Category not found: " + product.getCategory());
	            return false;
	        }

	        // Set parameters for the product insertion
	        stmt.setString(1, product.getProductName());
	        stmt.setInt(2, categoryId);  // Use the categoryId instead of category name
	        stmt.setDouble(3, product.getPrice());
	        stmt.setString(4, product.getStock());
	        stmt.setString(5, product.getDescription());
	        stmt.setString(6, product.getProductImage());

	        int affectedRows = stmt.executeUpdate();

	        return affectedRows > 0;  // Return true if rows were affected (successful insert), false otherwise
	    } catch (SQLException e) {
	        System.out.println("Error while inserting product: " + e.getMessage());
	        return false; // Return false in case of an error
	    }
	}

	// Helper method to get categoryId by category name
	private int getCategoryIdByName(String categoryName, Connection conn) throws SQLException {
	    String sql = "SELECT categoryId FROM category WHERE categoryName = ?";
	    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
	        stmt.setString(1, categoryName);
	        ResultSet rs = stmt.executeQuery();
	        if (rs.next()) {
	            return rs.getInt("categoryId");
	        } else {
	            return -1;  // Return -1 if category not found
	        }
	    }
	}


    // Retrieve all categories from the database
    public List<CategoryBean> getCategories() throws SQLException {
        List<CategoryBean> categories = new ArrayList<>();
        String sql = "SELECT * FROM category";

        try (Connection conn = DBconnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                CategoryBean category = new CategoryBean(rs.getInt("categoryId"), rs.getString("categoryName"));
                categories.add(category);
            }
        }
        return categories;
    }

    public boolean updateCategory(CategoryBean category) throws SQLException {
        String sql = "UPDATE category SET categoryName = ? WHERE categoryId = ?";

        try (Connection conn = DBconnection.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, category.getCategoryName());
            stmt.setInt(2, category.getCategoryId());
            int affectedRows = stmt.executeUpdate();

            return affectedRows > 0;  // Return true if the update is successful
        } catch (SQLException e) {
            System.out.println("Error while updating category: " + e.getMessage());
            return false;  // Return false in case of an error
        }
    }


    // Delete a category from the database
    public boolean deleteCategory(int categoryId) throws SQLException {
        String sql = "DELETE FROM category WHERE categoryId = ?";

        try (Connection conn = DBconnection.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, categoryId);
            int affectedRows = stmt.executeUpdate();

            return affectedRows > 0;  // Return true if the deletion is successful
        } catch (SQLException e) {
            System.out.println("Error while deleting category: " + e.getMessage());
            return false;  // Return false in case of an error
        }
    }

    public CategoryBean getCategoryById(int categoryId) throws SQLException {
        String sql = "SELECT * FROM category WHERE categoryId = ?";
        CategoryBean category = null;

        try (Connection conn = DBconnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, categoryId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    category = new CategoryBean(rs.getInt("categoryId"), rs.getString("categoryName"));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching category by ID: " + e.getMessage());
        }
        return category;
    }

}
