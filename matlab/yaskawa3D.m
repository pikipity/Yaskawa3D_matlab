function yaskawa3D
%
%initial app
loaddata;
inithome;
%creat button
demo_1 = uicontrol(fig_1,'String','Demo 1','callback',@demo_1_button,...
    'Position',[20 5 60 20]);

demo_2 = uicontrol(fig_1,'String','Demo 2','callback',@demo_2_button,...
    'Position',[100 5 60 20]);

clr_trail = uicontrol(fig_1,'String','Clear Trail','callback',@clear_button,...
    'Position',[180 5 60 20]);

home = uicontrol(fig_1,'String','Home','callback',@home_button,...
    'Position',[260 5 60 20]);

draw_trail=uicontrol(fig_1,'Style','checkbox','String','Draw trail',...
    'callback',@draw_trail_check,...
    'Position',[340 5 100 20]);

draw_trail_value='n';

%
% Kinematics Panel
%
K_p = uipanel(fig_1,...
    'units','pixels',...
    'Position',[20 45 215 200],...
    'Title','Kinematics','FontSize',11);

%     Angle    Range                Default 
%     Theta 1: 360 (-180 to 180)    0      
%     Theta 2: 270 (-45 to 225)     90      
%     Theta 3: 320 (-160 to 160)   -90     
%     Theta 4: 360 (-180 to 180)     0     
%     Theta 5: 320 (-160 to 160)     -90      
%     Theta 6: 360 (-180 to 180)     0      

t1_home = 0; % offset to define the "home" position as UP.
t2_home = 90;
t3_home = -90;
t4_home=0;
t5_home=-90;
t6_home=0;

LD = 105; % Left, used to set the GUI.
HT = 18;  % Height
BT = 156; % Bottom
%%  GUI buttons for Theta 1.  pos is: [left bottom width height]
t1_slider = uicontrol(K_p,'style','slider',...
    'Max',180,'Min',-180,'Value',t1_home,...
    'SliderStep',[0.05 0.2],...
    'callback',@t1_slider_button_press,...
    'Position',[LD-50 BT 120 HT]);
t1_min = uicontrol(K_p,'style','text',...
    'String','-180',...
    'Position',[LD-80 BT+1 25 HT-4]); % L, from bottom, W, H
t1_max = uicontrol(K_p,'style','text',...
    'String','+180',...
    'Position',[LD+75 BT+1 25 HT-4]); % L, B, W, H
t1_text = uibutton(K_p,'style','text',...  % Nice program Doug. Need this
    'String','\theta_1',...                % due to no TeX in uicontrols. 
    'Position',[LD-100 BT 20 HT],...
    'FontSize',15); % L, B, W, H
% % t1_text = uicontrol(K_p,'style','text',... % when matlab fixes uicontrol
% %     'String','t1',...                      % for TeX, then I can use this.  
% %     'Position',[LD-100 BT 20 HT]); % L, B, W, H
% t1_edit = uicontrol(K_p,'style','edit',...
%     'String',0,...
%     'callback',@t1_edit_button_press,...
%     'Position',[LD-85 BT 30 HT]); % L, B, W, H
%
%%  GUI buttons for Theta 2.
BT = 126;   % Bottom
t2_slider = uicontrol(K_p,'style','slider',...
    'Max',225,'Min',-45,'Value',t2_home,...        % Mech. stop limits !
    'SliderStep',[0.05 0.2],...
    'callback',@t2_slider_button_press,...
    'Position',[LD-50 BT 120 HT]);
t2_min = uicontrol(K_p,'style','text',...
    'String','-45',...
    'Position',[LD-80 BT+1 25 HT-4]); % L, from bottom, W, H
t2_max = uicontrol(K_p,'style','text',...
    'String','+225',...
    'Position',[LD+75 BT+1 25 HT-4]); % L, B, W, H
t2_text = uibutton(K_p,'style','text',...
    'String','\theta_2',...
    'Position',[LD-100 BT 20 HT]...
    ,'FontSize',15); % L, B, W, H
% t2_edit = uicontrol(K_p,'style','edit',...
%     'String',0,...
%     'callback',@t2_edit_button_press,...
%     'Position',[LD-85 BT 30 HT]); % L, B, W, H
%
%%  GUI buttons for Theta 3.
BT = 96;   % Bottom
t3_slider = uicontrol(K_p,'style','slider',...
    'Max',160,'Min',-160,'Value',t3_home,...
    'SliderStep',[0.05 0.2],...
    'callback',@t3_slider_button_press,...
    'Position',[LD-50 BT 120 HT]);
t3_min = uicontrol(K_p,'style','text',...
    'String','-160',...
    'Position',[LD-80 BT+1 25 HT-4]); % L, from bottom, W, H
t3_max = uicontrol(K_p,'style','text',...
    'String','+160',...
    'Position',[LD+75 BT+1 25 HT-4]); % L, B, W, H
t3_text = uibutton(K_p,'style','text',...
    'String','\theta_3',...
    'Position',[LD-100 BT 20 HT]...
    ,'FontSize',15); % L, B, W, H
% t3_edit = uicontrol(K_p,'style','edit',...
%     'String',0,...
%     'callback',@t3_edit_button_press,...
%     'Position',[LD-85 BT 30 HT]); % L, B, W, H
%
%%  GUI buttons for Theta 4.
BT = 66;   % Bottom
t4_slider = uicontrol(K_p,'style','slider',...
    'Max',180,'Min',-180,'Value',t4_home,...
    'SliderStep',[0.05 0.2],...
    'callback',@t4_slider_button_press,...
    'Position',[LD-50 BT 120 HT]);
t4_min = uicontrol(K_p,'style','text',...
    'String','-180',...
    'Position',[LD-80 BT+1 25 HT-4]); % L, from bottom, W, H
t4_max = uicontrol(K_p,'style','text',...
    'String','+180',...
    'Position',[LD+75 BT+1 25 HT-4]); % L, B, W, H
t4_text = uibutton(K_p,'style','text',...
    'String','\theta_4',...
    'Position',[LD-100 BT 20 HT]...
    ,'FontSize',15); % L, B, W, H
% t4_edit = uicontrol(K_p,'style','edit',...
%     'String',0,...
%     'callback',@t4_edit_button_press,...
%     'Position',[LD-85 BT 30 HT]); % L, B, W, H
%
%%  GUI buttons for Theta 5.
BT = 36;   % Bottom
t5_slider = uicontrol(K_p,'style','slider',...
    'Max',160,'Min',-160,'Value',t5_home,...
    'SliderStep',[0.05 0.2],...
    'callback',@t5_slider_button_press,...
    'Position',[LD-50 BT 120 HT]);
t5_min = uicontrol(K_p,'style','text',...
    'String','-160',...
    'Position',[LD-80 BT+1 25 HT-4]); % L, from bottom, W, H
t5_max = uicontrol(K_p,'style','text',...
    'String','+160',...
    'Position',[LD+75 BT+1 25 HT-4]); % L, B, W, H
t5_text = uibutton(K_p,'style','text',...
    'String','\theta_5',...
    'Position',[LD-100 BT 20 HT]...
    ,'FontSize',15); % L, B, W, H
% t5_edit = uicontrol(K_p,'style','edit',...
%     'String',0,...
%     'callback',@t5_edit_button_press,...
%     'Position',[LD-85 BT 30 HT]); % L, B, W, H
%
%%  GUI buttons for Theta 6.
BT = 6;   % Bottom
t6_slider = uicontrol(K_p,'style','slider',...
    'Max',180,'Min',-180,'Value',t6_home,...
    'SliderStep',[0.05 0.2],...
    'callback',@t6_slider_button_press,...
    'Position',[LD-50 BT 120 HT]);
t6_min = uicontrol(K_p,'style','text',...
    'String','-180',...
    'Position',[LD-80 BT+1 25 HT-4]); % L, from bottom, W, H
t6_max = uicontrol(K_p,'style','text',...
    'String','+180',...
    'Position',[LD+75 BT+1 25 HT-4]); % L, B, W, H
t6_text = uibutton(K_p,'style','text',...
    'String','\theta_6',...
    'Position',[LD-100 BT 20 HT]...
    ,'FontSize',15); % L, B, W, H
% t6_edit = uicontrol(K_p,'style','edit',...
%     'String',0,...
%     'callback',@t6_edit_button_press,...
%     'Position',[LD-85 BT 30 HT]); % L, B, W, H
%

%slide bar function
    function t1_slider_button_press(h,dummy)
        %get number from GUI
        slider_value = get(h,'Value');
        %get original theta value
        theta=getappdata(0,'theta_data');
        %get new theta
        theta.t1=slider_value/180*pi;
        %draw
        draw_robo(theta.t1,theta.t2,theta.t3,theta.t4,theta.t5,theta.t6,20,draw_trail_value);
    end

    function t2_slider_button_press(h,dummy)
        %get number from GUI
        slider_value = get(h,'Value');
        %get original theta value
        theta=getappdata(0,'theta_data');
        %get new theta
        theta.t2=slider_value/180*pi;
        %draw
        draw_robo(theta.t1,theta.t2,theta.t3,theta.t4,theta.t5,theta.t6,20,draw_trail_value);
    end

    function t3_slider_button_press(h,dummy)
        %get number from GUI
        slider_value = get(h,'Value');
        %get original theta value
        theta=getappdata(0,'theta_data');
        %get new theta
        theta.t3=slider_value/180*pi;
        %draw
        draw_robo(theta.t1,theta.t2,theta.t3,theta.t4,theta.t5,theta.t6,20,draw_trail_value);
    end

    function t4_slider_button_press(h,dummy)
        %get number from GUI
        slider_value = get(h,'Value');
        %get original theta value
        theta=getappdata(0,'theta_data');
        %get new theta
        theta.t4=slider_value/180*pi;
        %draw
        draw_robo(theta.t1,theta.t2,theta.t3,theta.t4,theta.t5,theta.t6,20,draw_trail_value);
    end

    function t5_slider_button_press(h,dummy)
        %get number from GUI
        slider_value = get(h,'Value');
        %get original theta value
        theta=getappdata(0,'theta_data');
        %get new theta
        theta.t5=slider_value/180*pi;
        %draw
        draw_robo(theta.t1,theta.t2,theta.t3,theta.t4,theta.t5,theta.t6,20,draw_trail_value);
    end

    function t6_slider_button_press(h,dummy)
        %get number from GUI
        slider_value = get(h,'Value');
        %get original theta value
        theta=getappdata(0,'theta_data');
        %get new theta
        theta.t6=slider_value/180*pi;
        %draw
        draw_robo(theta.t1,theta.t2,theta.t3,theta.t4,theta.t5,theta.t6,20,draw_trail_value);
    end

%
% Inverse Kinematics Panel
%
IK_point=[2000,0,2000];
IK_p = uipanel(fig_1,...
    'units','pixels',...
    'Position',[20 250 170 120],...
    'Title','Inverse Kinematics','FontSize',11);
LD = 140; % Left, used to set the GUI.
HT = 18;  % Height
BT = 80; % Bottom
%GUI x value for invers kinematics
x_value_IK = uibutton(IK_p,'style','text',...
    'String','X: ',...
    'Position',[LD-100 BT 20 HT]...
    ,'FontSize',15);
x_edit_IK=uicontrol(IK_p,'style','edit',...
    'String',IK_point(1),...
    'callback',@x_edit_IK_button,...
    'Position',[LD-75 BT 60 HT]);
x_unit_IK=uibutton(IK_p,'style','text',...
    'String','( mm )',...
    'Position',[LD-7 BT 20 HT]...
    ,'FontSize',10);
BT=60;
%GUI y value for inverse kinematics
y_value_IK = uibutton(IK_p,'style','text',...
    'String','Y: ',...
    'Position',[LD-100 BT 20 HT]...
    ,'FontSize',15);
y_edit_IK=uicontrol(IK_p,'style','edit',...
    'String',IK_point(2),...
    'callback',@y_edit_IK_button,...
    'Position',[LD-75 BT 60 HT]);
y_unit_IK=uibutton(IK_p,'style','text',...
    'String','( mm )',...
    'Position',[LD-7 BT 20 HT]...
    ,'FontSize',10);
BT=40;
%GUI y value for inverse kinematics
z_value_IK = uibutton(IK_p,'style','text',...
    'String','Z: ',...
    'Position',[LD-100 BT 20 HT]...
    ,'FontSize',15);
z_edit_IK=uicontrol(IK_p,'style','edit',...
    'String',IK_point(3),...
    'callback',@z_edit_IK_button,...
    'Position',[LD-75 BT 60 HT]);
z_unit_IK=uibutton(IK_p,'style','text',...
    'String','( mm )',...
    'Position',[LD-7 BT 20 HT]...
    ,'FontSize',10);
BT=10;
%GUI do inverse kinermatics
IK = uicontrol(IK_p,'String','Get Point','callback',@IK_button,...
    'Position',[LD-85 BT 60 HT]);

%
% draw line
%
start_point=[2000,0,2000];
stop_point=[1000,0,2000];
run_time=100;
DL_p = uipanel(fig_1,...
    'units','pixels',...
    'Position',[20 380 170 200],...
    'Title','Draw Line','FontSize',11);
LD = 140; % Left, used to set the GUI.
HT = 18;  % Height
BT = 160; % Bottom
%GUI x start value for inverse kinematics
x_start_value_IK = uibutton(DL_p,'style','text',...
    'String','Start X: ',...
    'Position',[LD-100 BT 20 HT]...
    ,'FontSize',15);
x_start_edit_IK=uicontrol(DL_p,'style','edit',...
    'String',start_point(1),...
    'callback',@x_start_IK_button,...
    'Position',[LD-65 BT 60 HT]);
x_unit_line=uibutton(DL_p,'style','text',...
    'String','( mm )',...
    'Position',[LD+2 BT 20 HT]...
    ,'FontSize',10);
BT=BT-20;
%GUI x start value for inverse kinematics
y_start_value_IK = uibutton(DL_p,'style','text',...
    'String','Start Y: ',...
    'Position',[LD-100 BT 20 HT]...
    ,'FontSize',15);
y_start_edit_IK=uicontrol(DL_p,'style','edit',...
    'String',start_point(2),...
    'callback',@y_start_IK_button,...
    'Position',[LD-65 BT 60 HT]);
y_unit_line=uibutton(DL_p,'style','text',...
    'String','( mm )',...
    'Position',[LD+2 BT 20 HT]...
    ,'FontSize',10);
BT=BT-20;
%GUI x start value for inverse kinematics
z_start_value_IK = uibutton(DL_p,'style','text',...
    'String','Start Z: ',...
    'Position',[LD-100 BT 20 HT]...
    ,'FontSize',15);
z_start_edit_IK=uicontrol(DL_p,'style','edit',...
    'String',start_point(3),...
    'callback',@z_start_IK_button,...
    'Position',[LD-65 BT 60 HT]);
z_unit_line=uibutton(DL_p,'style','text',...
    'String','( mm )',...
    'Position',[LD+2 BT 20 HT]...
    ,'FontSize',10);
BT=BT-20;
%GUI x start value for inverse kinematics
x_final_value_IK = uibutton(DL_p,'style','text',...
    'String','Final X: ',...
    'Position',[LD-100 BT 20 HT]...
    ,'FontSize',15);
x_final_edit_IK=uicontrol(DL_p,'style','edit',...
    'String',stop_point(1),...
    'callback',@x_final_IK_button,...
    'Position',[LD-65 BT 60 HT]);
x_final_unit_line=uibutton(DL_p,'style','text',...
    'String','( mm )',...
    'Position',[LD+2 BT 20 HT]...
    ,'FontSize',10);
BT=BT-20;
%GUI x start value for inverse kinematics
y_final_value_IK = uibutton(DL_p,'style','text',...
    'String','Final Y: ',...
    'Position',[LD-100 BT 20 HT]...
    ,'FontSize',15);
y_final_edit_IK=uicontrol(DL_p,'style','edit',...
    'String',stop_point(2),...
    'callback',@y_final_IK_button,...
    'Position',[LD-65 BT 60 HT]);
y_final_unit_line=uibutton(DL_p,'style','text',...
    'String','( mm )',...
    'Position',[LD+2 BT 20 HT]...
    ,'FontSize',10);
BT=BT-20;
%GUI x start value for inverse kinematics
z_final_value_IK = uibutton(DL_p,'style','text',...
    'String','Final Z: ',...
    'Position',[LD-100 BT 20 HT]...
    ,'FontSize',15);
z_final_edit_IK=uicontrol(DL_p,'style','edit',...
    'String',stop_point(3),...
    'callback',@z_final_IK_button,...
    'Position',[LD-65 BT 60 HT]);
z_final_unit_line=uibutton(DL_p,'style','text',...
    'String','( mm )',...
    'Position',[LD+2 BT 20 HT]...
    ,'FontSize',10);
BT=BT-20;
%GUI x start value for inverse kinematics
run_time_value_IK = uibutton(DL_p,'style','text',...
    'String','Time: ',...
    'Position',[LD-100 BT 20 HT]...
    ,'FontSize',15);
run_time_edit_IK=uicontrol(DL_p,'style','edit',...
    'String',run_time,...
    'callback',@run_time_IK_button,...
    'Position',[LD-65 BT 60 HT]);
BT=BT-30;
%GUI do inverse kinermatics
DL = uicontrol(DL_p,'String','Draw line','callback',@DL_button,...
    'Position',[LD-85 BT 60 HT]);
%draw line button function
    function x_start_IK_button(h,dummy)
        x_start_value=get(h,'String');
        try
            start_point(1)=str2double(x_start_value);
        catch
            errordlg('Please input a number, not a string.','Warning')
        end
    end
    function y_start_IK_button(h,dummy)
        y_start_value=get(h,'String');
        try
            start_point(2)=str2double(y_start_value);
        catch
            errordlg('Please input a number, not a string.','Warning')
        end
    end
    function z_start_IK_button(h,dummy)
        z_start_value=get(h,'String');
        try
            start_point(3)=str2double(z_start_value);
        catch
            errordlg('Please input a number, not a string.','Warning')
        end
    end
    function x_final_IK_button(h,dummy)
        x_final_value=get(h,'String');
        try
            stop_point(1)=str2double(x_final_value);
        catch
            errordlg('Please input a number, not a string.','Warning')
        end
    end
    function y_final_IK_button(h,dummy)
        y_final_value=get(h,'String');
        try
            stop_point(2)=str2double(y_final_value);
        catch
            errordlg('Please input a number, not a string.','Warning')
        end
    end
    function z_final_IK_button(h,dummy)
        z_final_value=get(h,'String');
        try
            stop_point(3)=str2double(z_final_value);
        catch
            errordlg('Please input a number, not a string.','Warning')
        end
    end
    function run_time_IK_button(h,dummy)
        run_time_value=get(h,'String');
        try
            run_time=str2double(run_time_value);
        catch
            errordlg('Please input a number, not a string.','Warning')
        end
    end
    function DL_button(h,dummy)
        draw_line();
    end

%from "start_point", "stop_point" and "run_time" to get data to control 
%robot draw a line
    function draw_line()
        if(~isreal(start_point(1)) || ~isreal(start_point(2)) || ~isreal(start_point(3)) ||...
                ~isreal(stop_point(1)) || ~isreal(stop_point(2)) || ~isreal(stop_point(3)) ||...
                ~isreal(run_time))
            errordlg('Please input a number, not a string.','Warning')
        else
            %check whether robot can get start point and final point
            %check start point
            IK_point=[start_point(1) start_point(2) start_point(3)];
            set(x_edit_IK,'String',IK_point(1));
            set(y_edit_IK,'String',IK_point(2));
            set(z_edit_IK,'String',IK_point(3));
            %prepare original angle
            theta_orign=getappdata(0,'theta_data');
            theta_orign_temp=theta_orign;
            theta_orign_matrix=[theta_orign.t1,theta_orign.t2,theta_orign.t3,theta_orign.t4,theta_orign.t5,theta_orign.t6
                                             0,0,0,0,0,0
                                             0,pi/4,0,0,pi/2,0
                                             0,pi/4,pi/2,0,pi/2,0
                                             0,pi/4,-pi/2,0,-pi/2,0
                                             0,pi,-pi/2,0,-pi/2,0
                                             0,pi/2,-pi/2,0,-pi/2,0
                                             0,pi,pi/2,0,0,0
                                             0,0,-pi/2,0,-pi/2,0
                                             0,3*pi/4,pi/2,0,pi/2,0
                                             0,3*pi/4,-pi/2,0,-pi/2,0];
            for i=1:size(theta_orign_matrix,1)
                %calculate target theta
                [t1,t2,t3,t4,t5,t6]=inverse_kin(theta_orign_matrix(i,1),theta_orign_matrix(i,2),theta_orign_matrix(i,3),theta_orign_matrix(i,4),theta_orign_matrix(i,5),theta_orign_matrix(i,6));
                if(~strcmp(t1,'none') && ~strcmp(t2,'none') && ~strcmp(t3,'none') && ~strcmp(t4,'none') && ~strcmp(t5,'none') && ~strcmp(t6,'none'))
                    break;
                end
            end
            %start point check result
            if(~strcmp(t1,'none') && ~strcmp(t2,'none') && ~strcmp(t3,'none') && ~strcmp(t4,'none') && ~strcmp(t5,'none') && ~strcmp(t6,'none'))
                %start point is OK
                %store start theta
                start_theta=[t1;t2;t3;t4;t5;t6];
                %draw start robo position
                draw_robo(start_theta(1),start_theta(2),start_theta(3),start_theta(4),start_theta(5),start_theta(6),20,'n','y');
                %check stop point
                IK_point=[stop_point(1) stop_point(2) stop_point(3)];
                set(x_edit_IK,'String',IK_point(1));
                set(y_edit_IK,'String',IK_point(2));
                set(z_edit_IK,'String',IK_point(3));
                %prepare original angle
                theta_orign=getappdata(0,'theta_data');
                theta_orign_matrix=[theta_orign.t1,theta_orign.t2,theta_orign.t3,theta_orign.t4,theta_orign.t5,theta_orign.t6
                                                 0,0,0,0,0,0
                                                 0,pi/4,0,0,pi/2,0
                                                 0,pi/4,pi/2,0,pi/2,0
                                                 0,pi/4,-pi/2,0,-pi/2,0
                                                 0,pi,-pi/2,0,-pi/2,0
                                                 0,pi/2,-pi/2,0,-pi/2,0
                                                 0,pi,pi/2,0,0,0
                                                 0,0,-pi/2,0,-pi/2,0
                                                0,3*pi/4,pi/2,0,pi/2,0
                                                0,3*pi/4,-pi/2,0,-pi/2,0];
                for i=1:size(theta_orign_matrix,1)
                    %calculate target theta
                    [t1,t2,t3,t4,t5,t6]=inverse_kin(theta_orign_matrix(i,1),theta_orign_matrix(i,2),theta_orign_matrix(i,3),theta_orign_matrix(i,4),theta_orign_matrix(i,5),theta_orign_matrix(i,6));
                    if(~strcmp(t1,'none') && ~strcmp(t2,'none') && ~strcmp(t3,'none') && ~strcmp(t4,'none') && ~strcmp(t5,'none') && ~strcmp(t6,'none'))
                        break;
                    end
                end
                %stop point check result
                if(~strcmp(t1,'none') && ~strcmp(t2,'none') && ~strcmp(t3,'none') && ~strcmp(t4,'none') && ~strcmp(t5,'none') && ~strcmp(t6,'none'))
                    %stop point is OK
                    %store stop theta
                    stop_theta=[t1;t2;t3;t4;t5;t6];
                    %Vx
                    Vx=(stop_point(1)-start_point(1))/run_time;
                    %Vy
                    Vy=(stop_point(2)-start_point(2))/run_time;
                    %Vz
                    Vz=(stop_point(3)-start_point(3))/run_time;
                    %calculate step theta
                    %store necceray data to base workspace
                    assignin('base','Vx',Vx);
                    assignin('base','Vy',Vy);
                    assignin('base','Vz',Vz);
                    assignin('base','start_theta',start_theta);
                    %use simulink to get step theta
                    sim_time_span=0:run_time;
                    [tout,station,theta_step]=sim('cal_theta_step',sim_time_span);
                    theta_step=theta_step';
                    %draw robot
                    draw_robo(theta_step(1,end),theta_step(2,end),theta_step(3,end),theta_step(4,end),theta_step(5,end),theta_step(6,end),theta_step,'y','y');
                    %goback position
                    draw_robo(theta_orign_temp.t1,theta_orign_temp.t2,theta_orign_temp.t3,theta_orign_temp.t4,theta_orign_temp.t5,theta_orign_temp.t6,20,'n','y');
                    msgbox('Job has been finished','Job finish');
                else
                    msgbox({'Robot cannot get this stop point.' ; 'Every thing will go to default value'},'Warning');
                    goback_value();
                    gohome();
                end
            else
                msgbox({'Robot cannot get this start point.'; 'Every thing will go to default value'},'Warning');
                goback_value();
                gohome();
            end
        end
    end

%Default value
    function goback_value()
        IK_point=[2000 0 2000];
        set(x_edit_IK,'String',IK_point(1));
        set(y_edit_IK,'String',IK_point(2));
        set(z_edit_IK,'String',IK_point(3));
        start_point=[2000,0,2000];
        stop_point=[1000,0,1000];
        run_time=10;
        set(x_start_edit_IK,'String',start_point(1));
        set(y_start_edit_IK,'String',start_point(2));
        set(z_start_edit_IK,'String',start_point(3));
        set(x_final_edit_IK,'String',stop_point(1));
        set(y_final_edit_IK,'String',stop_point(2));
        set(z_final_edit_IK,'String',stop_point(3));
        set(run_time_edit_IK,'String',run_time);
    end


% inverse kinermatics edit value functions
    function x_edit_IK_button(h,dummy)
        IK_x_value=get(h,'String');
        try
            IK_point(1)=str2double(IK_x_value);
        catch
            errordlg('Please input a number, not a string.','Warning')
        end
    end
    function y_edit_IK_button(h,dummy)
        IK_y_value=get(h,'String');
        try
            IK_point(2)=str2double(IK_y_value);
        catch
            errordlg('Please input a number, not a string.','Warning')
        end
    end
    function z_edit_IK_button(h,dummy)
        IK_z_value=get(h,'String');
        try
            IK_point(3)=str2double(IK_z_value);
        catch
            errordlg('Please input a number, not a string.','Warning')
        end
    end
%Get point function
    function IK_button(h,dummy)
        if(~isreal(IK_point(1)))
                errordlg('Please input a number, not a string.','Warning')
        end
        if(~isreal(IK_point(2)))
                errordlg('Please input a number, not a string.','Warning')
        end
        if(~isreal(IK_point(2)))
                errordlg('Please input a number, not a string.','Warning')
        end
        if(isreal(IK_point(1)) && isreal(IK_point(2)) && isreal(IK_point(3)))
            %prepare original angle
            theta_orign=getappdata(0,'theta_data');
            theta_orign_matrix=[theta_orign.t1,theta_orign.t2,theta_orign.t3,theta_orign.t4,theta_orign.t5,theta_orign.t6
                                             0,0,0,0,0,0
                                             0,pi/4,0,0,pi/2,0
                                             0,pi/4,pi/2,0,pi/2,0
                                             0,pi/4,-pi/2,0,-pi/2,0
                                             0,pi,-pi/2,0,-pi/2,0
                                             0,pi/2,-pi/2,0,-pi/2,0
                                             0,pi,pi/2,0,0,0
                                             0,0,-pi/2,0,-pi/2,0
                                             0,3*pi/4,pi/2,0,pi/2,0
                                             0,3*pi/4,-pi/2,0,-pi/2,0];
            for i=1:size(theta_orign_matrix,1)
                %calculate target theta
                [t1,t2,t3,t4,t5,t6]=inverse_kin(theta_orign_matrix(i,1),theta_orign_matrix(i,2),theta_orign_matrix(i,3),theta_orign_matrix(i,4),theta_orign_matrix(i,5),theta_orign_matrix(i,6));
                if(~strcmp(t1,'none') && ~strcmp(t2,'none') && ~strcmp(t3,'none') && ~strcmp(t4,'none') && ~strcmp(t5,'none') && ~strcmp(t6,'none'))
                    break;
                end
            end
            %draw robot
            if(~strcmp(t1,'none') && ~strcmp(t2,'none') && ~strcmp(t3,'none') && ~strcmp(t4,'none') && ~strcmp(t5,'none') && ~strcmp(t6,'none'))
                draw_robo(t1,t2,t3,t4,t5,t6,20,draw_trail_value,'y');
            else
                msgbox({'Robot cannot get this point.'; 'Every thing will go to default value'},'Warning');
                goback_value();
                gohome();
            end
        end
    end

%adjust angle to their range. If angle cannot go to their range, angle = 'none'
%period of angle is 2*pi
    function final_angle=adjust_angle(angle,min_num,max_num)
        if angle>max_num
            angle=angle-2*pi*floor((angle-max_num)/2*pi);
        elseif angle<min_num
            angle=angle+2*pi*ceil((angle-min_num)/2*pi);
        end
        if(angle<min_num || angle>max_num)
            final_angle='none';
        else
            final_angle=angle;
        end
    end

%inverse kinermatics. Get target point from "IK_point"
    function [t1,t2,t3,t4,t5,t6]=inverse_kin(t1o,t2o,t3o,t4o,t5o,t6o)
        %prepare begin point
        X0=[t1o,t2o,t3o,t4o,t5o,t6o];
        %solve
        theta=fsolve(@target_function,X0,optimset('Display','off',...
            'Algorithm','Levenberg-Marquardt'));
        %get ans
        t1=theta(1);
        t2=theta(2);
        t3=theta(3);
        t4=theta(4);
        t5=theta(5);
        t6=theta(6);
        %adjust ans
        t1=adjust_angle(t1,-pi,pi);
        t2=adjust_angle(t2,-45/180*pi,225/180*pi);
        t3=adjust_angle(t3,-160/180*pi,160/180*pi);
        t4=adjust_angle(t4,-pi,pi);
        t5=adjust_angle(t5,-160/180*pi,160/180*pi);
        t6=adjust_angle(t6,-pi,pi);
    end
    function F=target_function(x)
        t1=x(1);
        t2=x(2);
        t3=x(3);
        t4=x(4);
        t5=x(5);
        t6=x(6);
         %build transfer matrix according to themselves system
        T01=[cos(t1) -sin(t1) 0 0
                  sin(t1) cos(t1) 0 0
                  0 0 1 0
                  0 0 0 1];
        T12=[1 0 0 0
                  0 0 -1 0
                  0 1 0 725
                  0 0 0 1]*[cos(t2) -sin(t2) 0 0
                                 sin(t2) cos(t2) 0 0
                                 0 0 1 0
                                 0 0 0 1];
        T23=[cos(t3) -sin(t3) 0 1549.356
                 sin(t3) cos(t3) 0 0
                 0 0 1 -200
                 0 0 0 1];
        T34=[1 0 0 0
            0 cos(t4) -sin(t4) 0
            0 sin(t4) cos(t4) 0
            0 0 0 1];
        T45=[cos(t5) -sin(t5) 0 1549.356/2
                 sin(t5) cos(t5) 0 0
                 0 0 1 0
                 0 0 0 1];
        T56=[1 0 0 312
                 0 cos(t6) -sin(t6) 0
                 0 sin(t6) cos(t6) 0
                 0 0 0 1];
       %build transfer matrix according to original
       T02=T01*T12;
       T03=T02*T23;
       T04=T03*T34;
       T05=T04*T45;
       T06=T05*T56;
       %solve
       F=T06(1:3,4)-IK_point';
    end


%checkbox function for drawing trial
    function draw_trail_check(h,dummy)
        trail=get(h,'Value');
        if(trail)
            draw_trail_value='y';
        else
            draw_trail_value='n';
        end
    end

%go home button function: make all angle to default value
    function home_button(h,dummy)
         gohome();
    end
%go home
    function gohome()
        %get original theta value
        theta=getappdata(0,'theta_data');
        %get new theta
        theta.t1=t1_home/180*pi;
        theta.t2=t2_home/180*pi;
        theta.t3=t3_home/180*pi;
        theta.t4=t4_home/180*pi;
        theta.t5=t5_home/180*pi;
        theta.t6=t6_home/180*pi;
        %draw
        draw_robo(theta.t1,theta.t2,theta.t3,theta.t4,theta.t5,theta.t6,20,draw_trail_value,'y');
    end

%draw robot
    function draw_robo(t1,t2,t3,t4,t5,t6,step,draw_trial,change_slide)
        if nargin==8
            change_slide='n';
        end
        %get old theta
        theta=getappdata(0,'theta_data');
        %build step of theta
        if(size(step)==[1,1])
            if step<2
                step=2;
            end
            %calculate step for every angle
            t1_step=linspace(theta.t1,t1,step);
            t2_step=linspace(theta.t2,t2,step);
            t3_step=linspace(theta.t3,t3,step);
            t4_step=linspace(theta.t4,t4,step);
            t5_step=linspace(theta.t5,t5,step);
            t6_step=linspace(theta.t6,t6,step);
        else
            t1_step=step(1,:);
            t2_step=step(2,:);
            t3_step=step(3,:);
            t4_step=step(4,:);
            t5_step=step(5,:);
            t6_step=step(6,:);
            step=length(t1_step);
        end
        %get component 
        robo_part=getappdata(0,'robo');
        for i=2:step
            [base,J1,J2,J3,J4,J5,trial]=Kin(t1_step(i),t2_step(i),t3_step(i),t4_step(i),t5_step(i),t6_step(i),draw_trial);
            set(robo_part(1),'vertices',base.V);
            set(robo_part(2),'vertices',J1.V);
            set(robo_part(3),'vertices',J2.V);
            set(robo_part(4),'vertices',J3.V);
            set(robo_part(5),'vertices',J4.V);
            set(robo_part(6),'vertices',J5.V);
            if(draw_trial=='y')
                if isempty(trial.x)
                    trial_x=0;
                else
                    trial_x=trial.x;
                end
                if isempty(trial.y)
                    trial_y=0;
                else
                    trial_y=trial.y;
                end
                if isempty(trial.z)
                    trial_z=0;
                else
                    trial_z=trial.z;
                end
                set(robo_part(7),'xdata',trial_x,'ydata',trial_y,'zdata',trial_z);
            end
            %change slide
            if change_slide=='y'
                if(t1_step(i)*180/pi>180)
                    set(t1_slider,'Value',180);
                elseif(t1_step(i)*180/pi<-180)
                    set(t1_slider,'Value',-180);
                else
                    set(t1_slider,'Value',t1_step(i)*180/pi);
                end
                if(t2_step(i)*180/pi>225)
                    set(t2_slider,'Value',225);
                elseif(t2_step(i)*180/pi<-45)
                    set(t2_slider,'Value',-45);
                else
                    set(t2_slider,'Value',t2_step(i)*180/pi);
                end
                if(t3_step(i)*180/pi>160)
                    set(t3_slider,'Value',160);
                elseif(t3_step(i)*180/pi<-160)
                    set(t3_slider,'Value',-160);
                else
                    set(t3_slider,'Value',t3_step(i)*180/pi);
                end
                if(t4_step(i)*180/pi>180)
                    set(t4_slider,'Value',180);
                elseif(t4_step(i)*180/pi<-180)
                    set(t4_slider,'Value',-180);
                else
                    set(t4_slider,'Value',t4_step(i)*180/pi);
                end
                if(t5_step(i)*180/pi>160)
                    set(t5_slider,'Value',160);
                elseif(t5_step(i)*180/pi<-160)
                    set(t5_slider,'Value',-160);
                else
                    set(t5_slider,'Value',t5_step(i)*180/pi);
                end
                if(t6_step(i)*180/pi>180)
                    set(t6_slider,'Value',180);
                elseif(t6_step(i)*180/pi<-180)
                    set(t6_slider,'Value',-180);
                else
                    set(t6_slider,'Value',t6_step(i)*180/pi);
                end
            end
            drawnow
        end
        theta.t1=t1;
        theta.t2=t2;
        theta.t3=t3;
        theta.t4=t4;
        theta.t5=t5;
        theta.t6=t6;
        setappdata(0,'theta_data',theta);
    end

%Init Home window
    function inithome
        %init figure
        set(0,'Units','pixels')
        dim = get(0,'ScreenSize');
        fig_1 = figure('doublebuffer','on','Position',[0,35,dim(3)-200,dim(4)-110],...
            'MenuBar','none','Name','3D Yaskama Robot Graphical Demo',...
            'NumberTitle','off','CloseRequestFcn',@del_app);
        hold on;
        light                               % add a default light
        daspect([1 1 1])                    % Setting the aspect ratio
        view(135,25);
        title('Yaskama Robot');
        axis([-2.6360e+03 2.6360e+03 -2.6360e+03 2.6360e+03 0 3.361e3]);
        plot3([-2.6360e+03,2.6360e+03],[-2.6360e+03,-2.6360e+03],[0,0],'k')
        plot3([-2.6360e+03,-2.6360e+03],[-2.6360e+03,2.6360e+03],[0,0],'k')
        plot3([-2.6360e+03,-2.6360e+03],[-2.6360e+03,-2.6360e+03],[0,3.361e3],'k')
        plot3([-2.6360e+03,-2.6360e+03],[2.6360e+03,2.6360e+03],[0,3.361e3],'k')
        plot3([-2.6360e+03,2.6360e+03],[-2.6360e+03,-2.6360e+03],[3.361e3,3.361e3],'k')
        plot3([-2.6360e+03,-2.6360e+03],[-2.6360e+03,2.6360e+03],[3.361e3,3.361e3],'k')
        xlabel_text=xlabel('X (mm)');
        xlabel_posi=get(xlabel_text,'Position');
        ylabel_text=ylabel('Y (mm)');
        ylabel_posi=get(ylabel_text,'Position');
        zlabel_text=zlabel('Z (mm)');
        zlabel_posi=get(zlabel_text,'Position');
        set(xlabel_text,'Position',[xlabel_posi(1)-1200,xlabel_posi(2)-1000,xlabel_posi(3)]);
        set(ylabel_text,'Position',[ylabel_posi(1)-1000,ylabel_posi(2)-2000,ylabel_posi(3)]);
        set(zlabel_text,'Position',[zlabel_posi(1)-400,zlabel_posi(2),zlabel_posi(3)+1600]);
        set(zlabel_text,'Rotation',0)
        %get theta data
        theta=getappdata(0,'theta_data');
        %calculate the position of all components
        [base,J1,J2,J3,J4,J5,trial]=Kin(theta.t1,theta.t2,theta.t3,theta.t4,theta.t5,theta.t6,'n');
        %plot all component
        base_plot=patch('faces',base.F,'vertices',base.V, 'facec', [0.306,0.733,1], 'EdgeColor','none');
        J1_plot=patch('faces',J1.F,'vertices',J1.V, 'facec', [0.717,0.116,0.123], 'EdgeColor','none');
        J2_plot=patch('faces',J2.F,'vertices',J2.V, 'facec', [0.216,1,.583], 'EdgeColor','none');
        J3_plot=patch('faces',J3.F,'vertices',J3.V, 'facec', [0.306,0.733,1], 'EdgeColor','none');
        J4_plot=patch('faces',J4.F,'vertices',J4.V, 'facec', [1,0.542,0.493], 'EdgeColor','none');
        J5_plot=patch('faces',J5.F,'vertices',J5.V, 'facec', [0.216,1,.583], 'EdgeColor','none');
        trial_plot=plot3(0,0,0);
        %save all plot component to "robo"
        setappdata(0,'robo',[base_plot,J1_plot,J2_plot,J3_plot,J4_plot,J5_plot,trial_plot]);
    end
%load robot data
    function loaddata
        %load all data from mat file
        base=load('base.mat');
        J1=load('J1.mat');
        J2=load('J2.mat');
        J3=load('J3.mat');
        J4=load('J4.mat');
        J5=load('J5.mat');
        %generate trial
        trial=struct('x',[],'y',[],'z',[]);
        %generate theta
        theta=struct('t1',0,'t2',pi/2,'t3',-pi/2,'t4',0,'t5',-pi/2,'t6',0);
        %save all data to "patch_data" for app
        setappdata(0,'patch_data',[base,J1,J2,J3,J4,J5]);
        %save trial data
        setappdata(0,'trial_data',trial);
        %save theta data
        setappdata(0,'theta_data',theta);
    end

%% close function
    function del_app(varargin)
        rmappdata(0,'patch_data');
        rmappdata(0,'robo');
        rmappdata(0,'trial_data');
        rmappdata(0,'theta_data');
        evalin('base','clear Vx;clear Vy;clear Vz;clear start_theta;');
        delete(fig_1);
    end
%Kinermacit
%draw_trial: 'y' or 'n'
    function [base,J1,J2,J3,J4,J5,trial]=Kin(t1,t2,t3,t4,t5,t6,draw_trial)
        %get data from "patch_data"
        handle=getappdata(0,'patch_data');
        base=handle(1);
        J1=handle(2);
        J2=handle(3);
        J3=handle(4);
        J4=handle(5);
        J5=handle(6);
        trial=getappdata(0,'trial_data');
        %build transfer matrix according to themselves system
        T01=[cos(t1) -sin(t1) 0 0
                  sin(t1) cos(t1) 0 0
                  0 0 1 0
                  0 0 0 1];
        T12=[1 0 0 0
                  0 0 -1 0
                  0 1 0 725
                  0 0 0 1]*[cos(t2) -sin(t2) 0 0
                                 sin(t2) cos(t2) 0 0
                                 0 0 1 0
                                 0 0 0 1];
        T23=[cos(t3) -sin(t3) 0 1549.356
                 sin(t3) cos(t3) 0 0
                 0 0 1 -200
                 0 0 0 1];
        T34=[1 0 0 0
            0 cos(t4) -sin(t4) 0
            0 sin(t4) cos(t4) 0
            0 0 0 1];
        T45=[cos(t5) -sin(t5) 0 1549.356/2
                 sin(t5) cos(t5) 0 0
                 0 0 1 0
                 0 0 0 1];
        T56=[1 0 0 312
                 0 cos(t6) -sin(t6) 0
                 0 sin(t6) cos(t6) 0
                 0 0 0 1];
       %build transfer matrix according to original
       T02=T01*T12;
       T03=T02*T23;
       T04=T03*T34;
       T05=T04*T45;
       T06=T05*T56;
       %calculate all component
       % base
       base.V(:,4)=1;
       base.V=(T01*base.V')';
       base.V=base.V(:,1:3);
       %J1
       J1.V(:,4)=1;
       J1.V=(T02*J1.V')';
       J1.V=J1.V(:,1:3);
       %J2
       J2.V(:,4)=1;
       J2.V=(T03*J2.V')';
       J2.V=J2.V(:,1:3);
       %J3
       J3.V(:,4)=1;
       J3.V=(T04*J3.V')';
       J3.V=J3.V(:,1:3);
       %J4
       J4.V(:,4)=1;
       J4.V=(T05*J4.V')';
       J4.V=J4.V(:,1:3);
       %J5
       J5.V(:,4)=1;
       J5.V=(T06*J5.V')';
       J5.V=J5.V(:,1:3);
       if(draw_trial=='y')
           %get trial data
           trial.x=[trial.x T06(1,4)];
           trial.y=[trial.y T06(2,4)];
           trial.z=[trial.z T06(3,4)];
           setappdata(0,'trial_data',trial);
       end
    end

%clear trial button
    function clear_button(h,dummy)
        %clear trial matrix
        trial=getappdata(0,'trial_data');
        trial.x=[];
        trial.y=[];
        trial.z=[];
        setappdata(0,'trial_data',trial);
        %draw 0 trial
        robo_part=getappdata(0,'robo');
        set(robo_part(7),'xdata',0,'ydata',0,'zdata',0);
        drawnow
    end

%demo 1
    function demo_1_button(h,dummy)
        msgbox('This function has not been finished.')
    end

%demo 2
    function demo_2_button(h,dummy)
        msgbox('This function has not been finished.')
    end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% for button of ui. this is copied from internet
    function [hout,ax_out] = uibutton(varargin)
        %uibutton: Create pushbutton with more flexible labeling than uicontrol.
        % Usage:
        %   uibutton accepts all the same arguments as uicontrol except for the
        %   following property changes:
        %
        %     Property      Values
        %     -----------   ------------------------------------------------------
        %     Style         'pushbutton', 'togglebutton' or 'text', default =
        %                   'pushbutton'.
        %     String        Same as for text() including cell array of strings and
        %                   TeX or LaTeX interpretation.
        %     Interpreter   'tex', 'latex' or 'none', default = default for text()
        %
        % Syntax:
        %   handle = uibutton('PropertyName',PropertyValue,...)
        %   handle = uibutton(parent,'PropertyName',PropertyValue,...)
        %   [text_obj,axes_handle] = uibutton('Style','text',...
        %       'PropertyName',PropertyValue,...)
        %
        % uibutton creates a temporary axes and text object containing the text to
        % be displayed, captures the axes as an image, deletes the axes and then
        % displays the image on the uicontrol.  The handle to the uicontrol is
        % returned.  If you pass in a handle to an existing uicontol as the first
        % argument then uibutton will use that uicontrol and not create a new one.
        %
        % If the Style is set to 'text' then the axes object is not deleted and the
        % text object handle is returned (as well as the handle to the axes in a
        % second output argument).
        %
        % See also UICONTROL.

        % Version: 1.6, 20 April 2006
        % Author:  Douglas M. Schwarz
        % Email:   dmschwarz=ieee*org, dmschwarz=urgrad*rochester*edu
        % Real_email = regexprep(Email,{'=','*'},{'@','.'})


        % Detect if first argument is a uicontrol handle.
        keep_handle = false;
        if nargin > 0
            h = varargin{1};
            if isscalar(h) && ishandle(h) && strcmp(get(h,'Type'),'uicontrol')
                keep_handle = true;
                varargin(1) = [];
            end
        end

        % Parse arguments looking for 'Interpreter' property.  If found, note its
        % value and then remove it from where it was found.
        interp_value = get(0,'DefaultTextInterpreter');
        arg = 1;
        remove = [];
        while arg <= length(varargin)
            v = varargin{arg};
            if isstruct(v)
                fn = fieldnames(v);
                for i = 1:length(fn)
                    if strncmpi(fn{i},'interpreter',length(fn{i}))
                        interp_value = v.(fn{i});
                        v = rmfield(v,fn{i});
                    end
                end
                varargin{arg} = v;
                arg = arg + 1;
            elseif ischar(v)
                if strncmpi(v,'interpreter',length(v))
                    interp_value = varargin{arg+1};
                    remove = [remove,arg,arg+1];
                end
                arg = arg + 2;
            elseif arg == 1 && isscalar(v) && ishandle(v) && ...
                    any(strcmp(get(h,'Type'),{'figure','uipanel'}))
                arg = arg + 1;
            else
                error('Invalid property or uicontrol parent.')
            end
        end
        varargin(remove) = [];

        % Create uicontrol, get its properties then hide it.
        if keep_handle
            set(h,varargin{:})
        else
            h = uicontrol(varargin{:});
        end
        s = get(h);
        if ~any(strcmp(s.Style,{'pushbutton','togglebutton','text'}))
            delete(h)
            error('''Style'' must be pushbutton, togglebutton or text.')
        end
        set(h,'Visible','off')

        % Create axes.
        parent = get(h,'Parent');
        ax = axes('Parent',parent,...
            'Units',s.Units,...
            'Position',s.Position,...
            'XTick',[],'YTick',[],...
            'XColor',s.BackgroundColor,...
            'YColor',s.BackgroundColor,...
            'Box','on',...
            'Color',s.BackgroundColor);
        % Adjust size of axes for best appearance.
        set(ax,'Units','pixels')
        pos = round(get(ax,'Position'));
        if strcmp(s.Style,'text')
            set(ax,'Position',pos + [0 1 -1 -1])
        else
            set(ax,'Position',pos + [4 4 -8 -8])
        end
        switch s.HorizontalAlignment
            case 'left'
                x = 0.0;
            case 'center'
                x = 0.5;
            case 'right'
                x = 1;
        end
        % Create text object.
        text_obj = text('Parent',ax,...
            'Position',[x,0.5],...
            'String',s.String,...
            'Interpreter',interp_value,...
            'HorizontalAlignment',s.HorizontalAlignment,...
            'VerticalAlignment','middle',...
            'FontName',s.FontName,...
            'FontSize',s.FontSize,...
            'FontAngle',s.FontAngle,...
            'FontWeight',s.FontWeight,...
            'Color',s.ForegroundColor);

        % If we are creating something that looks like a text uicontrol then we're
        % all done and we return the text object and axes handles rather than a
        % uicontrol handle.
        if strcmp(s.Style,'text')
            delete(h)
            if nargout
                hout = text_obj;
                ax_out = ax;
            end
            return
        end

        % Capture image of axes and then delete the axes.
        frame = getframe(ax);
       % delete(ax)

        % Build RGB image, set background pixels to NaN and put it in 'CData' for
        % the uicontrol.
        if isempty(frame.colormap)
            rgb = frame.cdata;
        else
            rgb = reshape(frame.colormap(frame.cdata,:),[pos([4,3]),3]);
        end
        size_rgb = size(rgb);
        rgb = double(rgb)/255;
        back = repmat(permute(s.BackgroundColor,[1 3 2]),size_rgb(1:2));
        isback = all(rgb == back,3);
        rgb(repmat(isback,[1 1 3])) = NaN;
        set(h,'CData',rgb,'String','','Visible',s.Visible)

        % Assign output argument if necessary.
        if nargout
            hout = h;
        end
%%
    end
end