/// <reference path="../../../typings/jquery/jquery.d.ts"/>
/// <reference path="../../../typings/sweetalert/sweetalert.d.ts"/>

class Alert {
    title: string;
    message: string;

    constructor(title: string, message: string) {
        this.title = title;
        this.message = message;
    }

    ShowAfter(timeout: number) {
        setTimeout(() => {
            if ($(".main").text() === "Loading...") {
                sweetAlert({
                    type  : "warning",
                    title : this.title,
                    text  : this.message
                });
            }
        }, timeout);
    }
}

var ErrorHandling = {
    Message: (title, message) =>
        new Alert(title, message)
}