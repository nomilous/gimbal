module.exports = viewport = (opts, callback) -> 

    callback null, 

        headers: 'Content-Type': 'text/html'
        body: """
        <body>
            <style>
            body {
                background-color: green;
            }
            </style>
            <script src="./controller"></script>
        </body>
        """

viewport.$www = {}
