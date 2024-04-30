<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.BufferedReader, java.io.FileReader, java.io.IOException, java.util.ArrayList, java.util.List" %>
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CO2 Emissionsdaten</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        #header {
            background-color: #f8f9fa;
            padding: 10px;
            margin-bottom: 20px;
        }

        #header img {
            width: 10%;
            height: auto;
        }

        #header .org-name {
            font-size: 24px;
            font-weight: bold;
            margin-left: 10px;
        }

        #header .nav-links {
            float: right;
            margin-top: 10px;
        }

        #header .nav-links a {
            margin-left: 20px;
        }

        #co2-table-container {
            overflow: auto; /* Horizontales und vertikales Scrollen ermöglichen */
            max-height: 590px; /* Maximale Höhe des Containers */
        }

        .footer {
            position: fixed;
            bottom: 0;
            width: 100%;
            background-color: #f8f9fa;
            padding: 2px 0; /* Hier das Padding anpassen */
            text-align: center;
            font-size: 10px; /* Hier die Schriftgröße anpassen */
        }
    </style>
</head>
<body>
    <div id="header">
        <div class="container">
            <img src="https://static.vecteezy.com/ti/gratis-vektor/p1/26992899-reduzierung-der-co2-emissionen-symbolstoppen-sie-das-zeichen-des-klimawandels-fur-grafikdesign-logo-website-soziale-medien-mobile-app-ui-illustration-vektor.jpg" alt="Organization Logo">
            <span class="org-name">Like Zero To Hero</span>
            <div class="nav-links">
                <a href="index.jsp">Startseite</a>
                <a href="login.html">Login</a>
                <a href="#">Kontakt</a>
            </div>
        </div>
    </div>

    <div class="container">
        <h1 class="mt-5 mb-4">CO2 Emissionsdaten</h1>
        <input type="text" id="search-input" class="form-control mb-3" placeholder="Suche nach Land...">
        <div id="co2-table-container">
            <table id="co2-table" class="table table-striped">
                <tbody id="co2-table-body">
                    <% 
                        String csvFile = "/WEB-INF/CO2-Emissionen.csv";
                        String line = "";
                        String cvsSplitBy = ",";
                        List<String[]> data = new ArrayList<>();

                        try (BufferedReader br = new BufferedReader(new FileReader(getServletContext().getRealPath(csvFile)))) {
                            while ((line = br.readLine()) != null) {
                                String[] entry = line.split(cvsSplitBy);
                                if (!entry[0].equals("Data source") && !entry[0].equals("Data for")) {
                                    data.add(entry);
                                }
                            }
                        } catch (IOException e) {
                            e.printStackTrace();
                        }

                        for (String[] entry : data) {
                            %>
                            <tr>
                                <td><%= entry[0] %></td>
                                <% for (int i = 1; i < entry.length; i++) { %>
                                    <td><%= entry[i] %></td>
                                <% } %>
                            </tr>
                            <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <footer class="footer mt-auto py-3 bg-light">
        <div class="container text-center">
            <span class="text-muted">CO2 Emissionsdaten | Datenquelle: <a href="https://www.climatewatchdata.org/ghg-emissions?chartType=percentage&end_year=2020&start_year=1990">Climate Watch</a></span>
        </div>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    
    const searchInput = document.getElementById('search-input');
    const tableBody = document.getElementById('co2-table-body');

    searchInput.addEventListener('input', function(event) {
        const searchText = event.target.value.toLowerCase();
        const rows = tableBody.getElementsByTagName('tr');
        
        for (let row of rows) {
            const countryCell = row.cells[1]; 
            if (countryCell) {
                const countryText = countryCell.textContent.toLowerCase();
                if (countryText.includes(searchText) || row.rowIndex === 0) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            }
        }
    });
</script>
</body>
</html>




 



