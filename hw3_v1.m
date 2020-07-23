clc;clear;
tmp_result = zeros(7,100);%存每個episode
real_state_value = [1/6 2/6 3/6 4/6 5/6];
run_episode = zeros(7,100,100);
figure; hold on;
for run = 1 :100%跑100run
    state_value  = zeros(7,5)+0.5;
    for cout =1:100% 產生100個episode
        N = zeros(1,5);%初始化次數
        n = 3;%初始在Ｃ
        episode = n;
        while n~=0 && n~=6% 產生1個episode
            previous = n;
            if randi(2) == 1%left
                n = n - 1;
            else%right
                n = n + 1;
            end
            episode = [episode, n];
            if n == 6 
               r = 1;
            else
               r = 0;
            end
            if n == 0 || n ==6
                state_value(5,previous) = state_value(5, previous) + 0.05 * ( r - state_value(5, previous));
                state_value(6,previous) = state_value(6, previous) + 0.1 * ( r - state_value(6, previous));
                state_value(7,previous) = state_value(7, previous) + 0.15 * ( r - state_value(7, previous));
            else
                state_value(5,previous) = state_value(5, previous) + 0.05 * ( state_value(5, n) - state_value(5, previous));
                state_value(6,previous) = state_value(6, previous) + 0.1 * ( state_value(6, n) - state_value(6, previous));
                state_value(7,previous) = state_value(7, previous) + 0.15 * ( state_value(7, n) - state_value(7, previous));
            end
        end%更新完一次
        t = length(episode)-1;
        G = 0;%return = 0
        for i = t:-1:1
            if episode(i+1) == 6 
                G = 1;
            end
            state_value(1,episode(i)) = state_value(1,episode(i))+0.01*(G-state_value(1,episode(i)));
            state_value(2,episode(i)) = state_value(2,episode(i))+0.02*(G-state_value(2,episode(i))); 
            state_value(3,episode(i)) = state_value(3,episode(i))+0.03*(G-state_value(3,episode(i)));
            state_value(4,episode(i)) = state_value(4,episode(i))+0.04*(G-state_value(4,episode(i))); 
            N(episode(i)) = N(episode(i)) + 1;
            
        end
        run_episode(1, run, cout) = sqrt(mean((state_value(1, :).' - real_state_value(:)).^2));
        run_episode(2, run, cout) = sqrt(mean((state_value(2, :).' - real_state_value(:)).^2));
        run_episode(3, run, cout) = sqrt(mean((state_value(3, :).' - real_state_value(:)).^2));
        run_episode(4, run, cout) = sqrt(mean((state_value(4, :).' - real_state_value(:)).^2));
        run_episode(5, run, cout) = sqrt(mean((state_value(5, :).' - real_state_value(:)).^2)); 
        run_episode(6, run, cout) = sqrt(mean((state_value(6, :).' - real_state_value(:)).^2)); 
        run_episode(7, run, cout) = sqrt(mean((state_value(7, :).' - real_state_value(:)).^2));
    end
end
tmp_result = mean(run_episode,2);
plot(1:100,tmp_result(1,:),'Color', 'red');plot(1:100,tmp_result(2,:),'--','Color', 'red');plot(1:100,tmp_result(3,:),':','Color', 'red');plot(1:100,tmp_result(4,:),'Color', 'red');
plot(1:100,tmp_result(5,:),'Color', 'blue');plot(1:100,tmp_result(6,:),'Color', 'blue');plot(1:100,tmp_result(7,:),'Color', 'blue');