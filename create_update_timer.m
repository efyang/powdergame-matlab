function create_update_timer(timer_cb,period)
   t=timer;
   t.TimerFcn = timer_cb;
   t.Period   = period;
   t.ExecutionMode  = 'fixedrate';
   start(t);
end