require 'benchmark'

# application_controller's methods marking
# before -> 
  Benchmark.bm(7) do |bm|
    bm.report("Before:")   { notifications = Notification.where(recipient: current_user).newest_first.limit(9) }
    bm.report("After:") { notifications = Notification.includes(:recipient).where(recipient: current_user).newest_first.limit(9) }
  end