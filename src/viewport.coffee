module.exports = viewport = (opts, callback) -> 

    callback null, 

        headers: 'Content-Type': 'text/html'
        body: """
        <body>

            <script src="./build"> </script>
            <script src="./controller"> </script>

        </body>
        """

viewport.$www = {}
