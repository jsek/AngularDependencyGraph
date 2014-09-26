angular.module("MainModule",[])
.factory("Log", ($q) -> )
.factory("Main1", ($q, Log) -> )

angular.module("Module1",["MainModule"])
.factory("_1_Service1", (Log) -> )
.factory("_1_Service2", (Main1, Log) -> )

angular.module("Module2",["MainModule"])
.factory("_2_Service1", (Log) -> )
.factory("_2_Service2", (Main1, Log) -> )
.factory("_2_Service3", (Log) -> )

angular.module("Module3",["Module2"])
.factory("_3_Service1", (_2_Service2) -> )
.factory("_3_Service2", (_2_Service3) -> )

angular.module("Module4",["Module2"])
.factory("_4_Service1", (_2_Service1) -> )
.factory("_4_Service2", (_2_Service1) -> )

angular.module("Module5",["MainModule", "Module3"])
.factory("_5_Service1", (Main1, Log, _3_Service1) -> )
.factory("_5_Service2", (Log, _3_Service1) -> )
.factory("_5_Service3", (Log, _3_Service2) -> )

angular.module("Module6",["Module1", "Module2", "Module3", "Module5"])
.factory("_6_GreedyService1", (Log, _3_Service2, _2_Service1, _5_Service1, _5_Service2) -> )
