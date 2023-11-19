Highcharts.chart("supporters_graph", {
    chart: {
        type: "column",
    },
    title: {
        text: "Número de Hinchas Registrados por Deporte",
    },
    xAxis: {
        categories: [
            "Clavados",
            "Natación",
            "Natación artística",
            "Polo acuático",
            "Natación en Aguas abiertas",
            "Maratón",
            "Marcha",
            "Atletismo",
            "Bádminton",
            "Balonmano",
            "Básquetbol",
            "Básquetbol 3x3",
            "Béisbol",
            "Boxeo",
            "Bowling",
            "Breaking",
            "Canotaje Slalom",
            "Canotaje de velocidad",
            "BMX Freestyle",
            "BMX Racing",
            "Mountain Bike",
            "Ciclismo pista",
            "Ciclismo ruta",
            "Adiestramiento ecuestre",
            "Evento completo ecuestre",
            "Salto ecuestre",
            "Escalada deportiva",
            "Esgrima",
            "Esquí acuático y Wakeboard",
            "Fútbol",
            "Gimnasia artística Masculina",
            "Gimnasia artística Femenina",
            "Gimnasia rítmica",
            "Gimnasia trampolín",
            "Golf",
            "Hockey césped",
            "Judo",
            "Karate",
            "Levantamiento de pesas",
            "Lucha",
            "Patinaje artístico",
            "Skateboarding",
            "Patinaje velocidad",
            "Pelota vasca",
            "Pentatlón moderno",
            "Racquetball",
            "Remo",
            "Rugby 7",
            "Sóftbol",
            "Squash",
            "Surf",
            "Taekwondo",
            "Tenis",
            "Tenis de mesa",
            "Tiro",
            "Tiro con arco",
            "Triatlón",
            "Vela",
            "Vóleibol",
            "Vóleibol playa"
        ],
        title: {
        text: "Deportes",
        },
    },
    yAxis: {
        min: 0,
        title: {
        text: "Cantidad de Hinchas",
        },
    },
    legend: {
        align: "left",
        verticalAlign: "top",
        borderWidth: 0,
    },

    tooltip: {
        shared: true,
        crosshairs: true,
    },

    series: [
        {
        name: "Hinchas",
        data: [],
        lineWidth: 1,
        marker: {
            enabled: true,
            radius: 4,
        },
        color: "#B695C0",
        },
    ],
});


Highcharts.chart("artisans_graph", {
    chart: {
        type: "column",
    },
    title: {
        text: "Número de Artesanos Registrados por Tipo de Artesanía",
    },
    xAxis: {
        // categories: [
        //     "Mármol",
        //     "Madera",
        //     "Cerámica",
        //     "Mimbre", 
        //     "Metal",
        //     "Cuero", 
        //     "Telas", 
        //     "Joyas", 
        //     "Otro"
        // ],
        title: {
        text: "Tipos de Artesanía",
        },
    },
    yAxis: {
        min: 0,
        title: {
        text: "Cantidad de Artesanos",
        },
    },
    legend: {
        align: "left",
        verticalAlign: "top",
        borderWidth: 0,
    },

    tooltip: {
        shared: true,
        crosshairs: true,
    },

    series: [
        {
        name: "Artesanos",
        data: [],
        lineWidth: 1,
        marker: {
            enabled: true,
            radius: 4,
        },
        color: "#f47e8e",
        },
    ],
});


fetch("http://localhost:5000/datos_graficos")
.then((response) => response.json())
.then((data) => {
    let supporters_data = data[0].map((item) => [item.sport, item.count]);
    let artisans_data = data[1].map((item) => [item.type, item.count]);
    let sports = data[0].map((item) => item.sport);
    let handicraft_types = data[1].map((item) => item.type);

    const supporters_chart = Highcharts.charts.find(
        (chart) => chart && chart.renderTo.id === "supporters_graph"
    );
    const artisans_chart = Highcharts.charts.find(
        (chart) => chart && chart.renderTo.id === "artisans_graph"
    );

    supporters_chart.xAxis[0].update({
        categories: sports
    })
    supporters_chart.update({
        series: [
            {
                data: supporters_data,
            },
        ],
    });

    artisans_chart.xAxis[0].update({
        categories: handicraft_types
    })
    artisans_chart.update({
        series: [
            {
                data: artisans_data,
            },
        ],
    });
}).catch((error) => console.error("Error:", error));