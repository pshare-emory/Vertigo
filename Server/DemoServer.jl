#Pkg.update()
getipaddr()
#versioninfo()
# para setting

# Parts=2;
NETWORK=Dict{Any,Any}("server_IP"=>"132.239.245.154",
                      "msgPort"=>4001,
                      "dataPort"=>4002)
#{"server_IP"=>"132.239.245.154","msgPort"=>5001,"dataPort"=>5002}

users=cell(2,7)
users[1,:]=  ["u001"  "UCSD001"   0  true   now()  true  "123456"];
users[1,3]=cell(0);
users[2,:]=  ["u002"  "UCSD002"   0  true   now()  true  "123456"];
users[2,3]=cell(0);

jobs= cell(2,4);
jobs[1,:]=["t001"  "u001"  false  0];
jobs[2,:]=["t001"  "u002"  false  0];
jobs[1,4]=cell(0);
jobs[2,4]=cell(0)

currentTask=cell(1,5);
currentTask = ["t001"  "VERTIGO" 0  9  0];
currentTask[3]=cell(0);
currentTask[5]=cell(0);

shutdown_job = ["shutdown"  "u005"  false];

DB=Dict{Any,Any}("users"=>users,
                 "jobs"=>jobs,
                 "shutdown_job"=>shutdown_job,
                 "currentTask"=>currentTask,
                 "joined_count"=>0,
                 "joined_count_data"=>0,
                 "isActive"=>false);

TIMEOUT= Dict{Any,Any}("ACCEPT"=>0.1,
                       "ACCEPT_data"=>1,
                       "RECEIVE"=>0.01,
                       "RECEIVE_data"=>1,
                       "OFFLINE_CHECKPOINT"=>30000,
                       "OFFLINE_THRESHOLD"=>30000,
                       "pending_Calc_Threshold"=>30);

MSG_CODEBOOK=Dict{Any,Any}("break"=>0,
                           "create_Lab_Connection"=>1,
                           "add_socks_list"=>2,
                           "confirm_new_client"=>3,
                           "confirm_online_client"=>4,
                           "confirm_online_clientFromDatalistener"=>5,
                           "closeServerByClient"=>6,
                           "remove_socks_list"=>7,
                           "getNewData"=>8,
                           "sendNewData"=>9,
                           "updateCalculation"=>10,
                           "updateCalculation_Done"=>11,
                           "updateCalculation_Fail"=>12,
                           "stopCalculation"=>13,
                           "pauseCalculation"=>14,
                           "checkClient"=>15,
                           "receiveClient2ServerData"=>16);
rho=1.0;
ParaInServer=Dict{Any,Any}("lambda"=>1.0,
                           "iter"=>0,
                           "maxit"=>1000,
                           "tol"=>1e-7);

#add processors
addprocs(1)
np=nprocs()
include("newClientListener.jl")
include("newDataListener.jl")

#main loop
tic()
output=newClientListener(TIMEOUT, MSG_CODEBOOK, NETWORK, DB, ParaInServer)
toc()
println("The task is done!!!!!!");
