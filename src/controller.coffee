

module.exports = controller = (opts, callback) -> 

    callback null, 

        headers: 'Content-Type': 'text/javascript'
        body: """
        alert('okgood');
        """

controller.$www = {}
