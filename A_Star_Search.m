
function goalsdata= A_Star_Search()%,init)
%clc; clear all; clear classes;


%cam=webcam('Logitech Webcam 120');
%preview(cam);

cost=1;
%costLeft=2;
%costRight=2;
Found=false;
Resign=false;

grid=NewGrid();
robotxy=[3 2]

init = [1 1]; %Start
goal = [robotxy(2) robotxy(1)]; % Goal.

Heuristic=CalculateHeuristic(grid,goal); %Calculate the Heuristic   
 
ExpansionGrid(1:size(grid,1),1:size(grid,2)) = -1; % to show the path of expansion

ActionTaken=zeros(size(grid)); %Matrix to store the action taken to reach that particular cell

OptimalPath(1:size(grid,1),1:size(grid,2))={' '}; %Optimal Path derived from A Star

%how to move in the grid

delta = [-1,  0; % go up
          0, -1; % go left
          1,  0; %go down
          0,  1]; % go right
 

 
 for i=1:size(grid,1)
     for j=1:size(grid,2)
         gridCell=search();
         if(grid(i,j)>0)
            gridCell=gridCell.Set(i,j,1,Heuristic(i,j));
         else
             gridCell=gridCell.Set(i,j,0,Heuristic(i,j));
         end
         GRID(i,j)=gridCell;
         clear gridCell;
     end
 end

Start=search();
Start=Start.Set(init(1),init(2),grid(init(1),init(2)),Heuristic(init(1),init(2)));
Start.isChecked=1;
GRID(Start.currX,Start.currY).isChecked=1;
Goal=search();
Goal=Goal.Set(goal(1),goal(2),grid(goal(1),goal(2)),0);
 
OpenList=[Start];
ExpansionGrid(Start.currX,Start.currY)=0;

small=Start.gValue+Start.hValue;

count=0;
 while(Found==false || Resign==false) 
    
 small=OpenList(1).gValue+OpenList(1).hValue+cost;

for i=1:size(OpenList,2)
        fValue=OpenList(i).gValue+OpenList(i).hValue;
        if(fValue<=small)
            small=fValue;
            ExpandNode=OpenList(i);
            OpenListIndex=i;
        end
    end
    
   
    OpenList(OpenListIndex)=[];

    
    ExpansionGrid(ExpandNode.currX,ExpandNode.currY)=count;
    count=count+1;
    
    for i=1:size(delta,1)
        direction=delta(i,:);
        if(ExpandNode.currX+ direction(1)<1 || ExpandNode.currX+direction(1)>size(grid,1)|| ExpandNode.currY+ direction(2)<1 || ExpandNode.currY+direction(2)>size(grid,2))
            continue;
        else
            NewCell=GRID(ExpandNode.currX+direction(1),ExpandNode.currY+direction(2));
            
             if(NewCell.isChecked~=1 && NewCell.isEmpty~=1)
                GRID(NewCell.currX,NewCell.currY).gValue=GRID(ExpandNode.currX,ExpandNode.currY).gValue+cost;
                GRID(NewCell.currX,NewCell.currY).isChecked=1; %modified line from the v1
                OpenList=[OpenList,GRID(NewCell.currX,NewCell.currY)]; 
                ActionTaken(NewCell.currX,NewCell.currY)=i;
             end
            
             if(NewCell.currX==Goal.currX && NewCell.currY==Goal.currY && NewCell.isEmpty~=1)
                Found=true;
                Resign=true;
                disp('Search Successful');
                GRID(NewCell.currX,NewCell.currY).isChecked=1;
                ExpansionGrid(NewCell.currX,NewCell.currY)=count;
                GRID(NewCell.currX,NewCell.currY)
                break;
            end
            
        end
    end

     if(isempty(OpenList) && Found==false)
         Resign=true;
         disp('Search Failed');
         break;
     end
 end
 
 
 Policy={'Up','Left','Down','Right'};
 X=goal(1);Y=goal(2);
 OptimalPath(X,Y)={'GOAL'};
 i=1;
 %PreviousOptimalPath1={'Goal'};
 %goalsdata=ones(1,40);
 
 %display(x2);
 %display(X);
 %display(ActionTaken(X,Y),1);
 x2=X-delta(ActionTaken(X,Y),1);
     y2=Y-delta(ActionTaken(X,Y),2);
     OptimalPath(x2,y2)=Policy(ActionTaken(X,Y));
        Previous1=Policy(ActionTaken(X,Y));
        xs1=X;
        ys1=Y;
       
    X=x2;
     Y=y2;
        x2=X-delta(ActionTaken(X,Y),1);
     y2=Y-delta(ActionTaken(X,Y),2);
     OptimalPath(x2,y2)=Policy(ActionTaken(X,Y));
  Previous2=Policy(ActionTaken(X,Y));
  xs2=X;
  ys2=Y
    X=x2;
     Y=y2;
     
        x2=X-delta(ActionTaken(X,Y),1);
     y2=Y-delta(ActionTaken(X,Y),2);
     OptimalPath(x2,y2)=Policy(ActionTaken(X,Y));
  Previous3=Policy(ActionTaken(X,Y));
    xs3=X;
  ys3=Y
    X=x2;
     Y=y2;
 %PreviousOptimalPath=OptimalPath(X,Y);
 while(X~=init(1)|| Y~=init(2))
     x2=X-delta(ActionTaken(X,Y),1);
     y2=Y-delta(ActionTaken(X,Y),2);
     OptimalPath(x2,y2)=Policy(ActionTaken(X,Y));
     if(~strcmp(Previous2,OptimalPath(x2,y2)))
         if(~strcmp(Previous1,Previous2))
         goalsdata(i)=xs1;
         goalsdata(i+1)=ys1;
         i=i+2;
         end
         
     end
     
     xs1=xs2;
     ys1=ys2;
     xs2=xs3;
     ys2=ys3;
     xs3=X;
     ys3=Y;
     
     
     
     Previous1=Previous2;
     Previous2=Previous3;
     Previous3=Policy(ActionTaken(X,Y));
   
 
    X=x2;
     Y=y2;

 end
 
 
 %while(X~=init(1)|| Y~=init(2))
  %   x2=X-delta(ActionTaken(X,Y),1);
   %  y2=Y-delta(ActionTaken(X,Y),2);
    % OptimalPath(x2,y2)=Policy(ActionTaken(X,Y));
    % if(~strcmp(Previous2,OptimalPath(x2,y2)))
     %    if(~strcmp(Previous1,Previous2))
      %   goalsdata(i)=xs1;
       %  goalsdata(i+1)=ys1;
        % i=i+2;
        % end
       
 ExpansionGrid %to see how the expansion took place
 OptimalPath %to see the optimal path taken by the Search Algo
 %display(goalsdata);  
     end
     
     
     
   
 
  %  X=x2;
 %    Y=y2;
%..3
 %end
 
 
 %goalsStore(goalsdata);

 %goalsdata(i)=init(1);
 %goalsdata(i+1)=init(2);
%i=i+2;
%display(goalsdata);
%end