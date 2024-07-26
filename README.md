# Appendicularia Project
Prediction of appendicular abundance as a function of environmental data.
This code explores data, performs principal component analyses, fits gradient boosting models to predict appendicular abundance, and evaluates the performance of the fitted models.

### **Description**
Net towns and CTD casts were performed around an oceanic island in the South Pacific. All records are considered independent. The abundance of plankton as well as several physical parameters of the environment were recorded.
- **Question : What are the main environmental factors affecting the abundance of Appendicularia? Do they have a strong influence?**


### **Variable description**
</head>
<body>
    <table>
        <thead>
            <tr>
                <th>Variable</th>
                <th>Description</th>
                <th>Unité</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>appendicularia</td>
                <td>Abundance of appendicularia</td>
                <td>Total nb of individuals per station</td>
            </tr>
            <tr>
                <td>thermocline</td>
                <td>Depth of the thermocline</td>
                <td>m from the surface</td>
            </tr>
            <tr>
                <td>halocline</td>
                <td>Depth of the halocline</td>
                <td>m from the surface</td>
            </tr>
            <tr>
                <td>pycnocline</td>
                <td>Depth of the pycnocline</td>
                <td>m from the surface</td>
            </tr>
            <tr>
                <td>chloroMax</td>
                <td>Depth of the chlorophyll maximum</td>
                <td>m from the surface</td>
            </tr>
            <tr>
                <td>mixedDepth</td>
                <td>Depth of the mixed layer (base of the pycnocline)</td>
                <td>m from the surface</td>
            </tr>
            <tr>
                <td>temperature</td>
                <td>Temperature</td>
                <td>degree C</td>
            </tr>
            <tr>
                <td>salinity</td>
                <td>Salinity</td>
                <td>PSU</td>
            </tr>
            <tr>
                <td>density</td>
                <td>Density anomaly with respect to fresh water</td>
                <td>-</td>
            </tr>
            <tr>
                <td>fluorimetry</td>
                <td>Fluorimetry</td>
                <td>volts</td>
            </tr>
            <tr>
                <td>average temperature, salinity, density, fluorimetry in the mixed layer</td>
                <td>Average values in the mixed layer</td>
                <td>-</td>
            </tr>
            <tr>
                <td>windSpeed</td>
                <td>Wind speed at the surface</td>
                <td>m/s</td>
            </tr>
            <tr>
                <td>distance</td>
                <td>Distance from land</td>
                <td>m</td>
            </tr>
            <tr>
                <td>currentSpeed</td>
                <td>Average current speed in the mixed layer</td>
                <td>m/s</td>
            </tr>
            <tr>
                <td>timeOfDay</td>
                <td>Time of the day</td>
                <td>day or night</td>
            </tr>
        </tbody>
    </table>
</body>
