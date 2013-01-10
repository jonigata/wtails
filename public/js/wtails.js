var Wtails = {
    run: function(port) {
        var self = this;
        jQuery(function($) {
            var socket = new (WebSocket || MozWebSocket)('ws://localhost:' + port);
            var context = { port: port };
            socket.onmessage = function(message) {
                $.each(self.onmessages, function() { this(message, context); });
            };
        });
    },

    onmessages: [
        function(message, context) {
            // To ignore serial empty lines
            if (message.data == '\n' && $('pre:last').text() == '\n') return;

            // Insert a new line
            var target = $('.port-' + context.port);
            target.append($('<pre>').text(message.data));

            // Scroll to bottom of the page
            target.each(function() {
                $(this).parent().scrollTop($(this).height());
            });
        }
    ]
};
