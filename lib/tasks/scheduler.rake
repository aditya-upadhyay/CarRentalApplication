desc "Checking Car returned"
task not_returned: :environment do
  puts "Checking cars not returned"
  @reservation = Reservation.where(:active => true)
  @reservation.each do |c|
    if(c.return_time < DateTime.now)
      @c=c
      c.active=true
      c.save
      puts "here"
      @car=Car.find_by(id: c.car_id)
      @car.status = 'Available'
      @car.save
    end
  end
  puts "and here"
end

desc "Checking for 30min delay for checkout"
task change_uncheckedout_car: :environment do
  puts "Uncheckedout car checking"
  @reservation = Reservation.where(:active => true)
  @reservation.each do |a|
    puts "Checkedout or not"
    if((a.return_time+60*30) < DateTime.now)
      a.active = false
      a.save
      @a=a
      @car = Car.find_by(id: a.car_id)
      @car.status = 'Available'
      @car.save
    end
    puts "here"
  end
end