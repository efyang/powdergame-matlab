function create_update_timer(timer_cb,period)
% makes an update timer with a callback timer_cb and period
   t=timer;
   t.TimerFcn = timer_cb;
   t.Period   = period;
   t.ExecutionMode  = 'fixeddelay';
   start(t);
end