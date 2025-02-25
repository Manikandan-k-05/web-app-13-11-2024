<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String email = (String) session.getAttribute("userEmail");

    if (email == null) {
        response.sendRedirect("log.jsp");
        return;  // Exit the page
    }

    out.print(email);  // Display the email if session is valid
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sports World - Payment</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <a class="navbar-brand text-danger" href="#">Sports World</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav"> 
        <ul class="navbar-nav ml-auto">
            <li class="nav-item"><a class="nav-link text-danger" href="home.jsp">Home</a></li>
            <li class="nav-item"><a class="nav-link text-danger" href="shop.jsp">Shop</a></li>
            <li class="nav-item"><a class="nav-link text-danger" href="cart.jsp">Cart</a></li>
            <li class="nav-item"><a class="nav-link text-danger" href="payment.jsp">Payment</a></li>
            <li class="nav-item"><a class="nav-link text-danger" href="#">Log</a></li>
        </ul>
    </div>  
</nav>

<!-- Payment Section -->
<div class="container my-5">
    <h2 class="text-center text-danger mb-4">Payment</h2>
    <div class="row">
        <div class="col-md-6 offset-md-3">
            <div class="card">
                <div class="card-body">
                    <form action="confirmPayment.jsp" method="post">
                        <!-- Billing Information -->
                        <h5 class="card-title text-danger">Billing Information</h5>
                        <div class="form-group">
                            <label for="name">Full Name</label>
                            <input type="text" class="form-control" id="name" name="name" required>
                        </div>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <div class="form-group">
                            <label for="address">Address</label>
                            <input type="text" class="form-control" id="address" name="address" required>
                        </div>
                        <div class="form-group">
                            <label for="city">City</label>
                            <input type="text" class="form-control" id="city" name="city" required>
                        </div>
                        <div class="form-group">
                            <label for="zip">ZIP Code</label>
                            <input type="text" class="form-control" id="zip" name="zip" required>
                        </div>
                        
                        <!-- Payment Method -->
                        <h5 class="card-title text-danger mt-4">Payment Method</h5>
                        <div class="form-group">
                            <label for="cardNumber">Card Number</label>
                            <input type="text" class="form-control" id="cardNumber" name="cardNumber" required>
                        </div>
                        <div class="form-group">
                            <label for="expDate">Expiration Date</label>
                            <input type="month" class="form-control" id="expDate" name="expDate" required>
                        </div>
                        <div class="form-group">
                            <label for="cvv">CVV</label>
                            <input type="text" class="form-control" id="cvv" name="cvv" required>
                        </div>
                        
                        <!-- Order Summary -->
                        <h5 class="card-title text-danger mt-4">Order Summary</h5>
                        <p>Subtotal: $20</p>
                        <p>Tax: $2</p>
                        <hr>
                        <h5>Total: $22</h5>

                        <button type="submit" class="btn btn-danger btn-block mt-4">Confirm Payment</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="bg-danger text-white text-center py-3">
    <p>&copy; 2024 Sports World. All Rights Reserved.</p>
</footer>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
