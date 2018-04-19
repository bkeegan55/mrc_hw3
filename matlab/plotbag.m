%Ben Keegan
%ME4823
%Assignment 3 Exercise #4
%18APR18
%
% Create a bag file object with the file name
% by omitting the semicolon this displays some information about
% the bag file
bag = rosbag('../data/myturtle.bag')
 
% Display a list of the topics and message types in the bag file
bag.AvailableTopics
 
% Since the messages on topic turtle1/pose are of type Twist,
% let's see some of the attributes of the Twist message
msg_pose = rosmessage('turtlesim/Pose')
showdetails(msg_pose)
 
% Get just the topic we are interested in
bagselect = select(bag,'Topic','turtle1/pose');
 
% Create a time series object based on the fields of the turtlesim/Pose
% message we are interested in
ts = timeseries(bagselect,'X','Y','Theta','LinearVelocity','AngularVelocity');

% Plots
t = ts.Time;
x = ts.Data(:,1);
y = ts.Data(:,2);
th = ts.Data(:,3);
vel = ts.Data(:,4);
ang_vel = ts.Data(:,5);
u = vel.*cos(th);
v = vel.*sin(th);
ii = 1:10:length(x);  % Decimate the data so that it plot only every Nth point.
figure(1);
quiver(x(ii),y(ii),u(ii),v(ii));
title('Quiver Plot of turtle1/pose');
xlabel('X [?]'); ylabel('Y [?]');

figure(2);
plot(x(ii),y(ii));
title('Plot of turtle1/pose X and Y');
xlabel('X [?]'); ylabel('Y [?]');

figure(3);
plot(t(ii),th(ii));
title('Plot of turtle1/pose Heading vs. Time');
xlabel('Time [s]'); ylabel('Heading [rad]');
