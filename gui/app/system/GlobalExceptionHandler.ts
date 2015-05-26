/// <reference path="../../../typings/node/node.d.ts"/>
/// <reference path="../../../typings/sweetalert/sweetalert.d.ts"/>


// Global Exception Handler
process.on("uncaughtException", (err) => {
    console.warn(`Uncaught exception: ${err}`);
    sweetAlert({
        title: "Looks like we messed up... :(",
        text: "See exception details in [DevTools] > [Console]"
    });
});