# frozen_string_literal: true

Category.delete_all
home = Category.create(name: 'HOME SERVICE'.titleize)
ESSENTIALS = Category.create(name: 'ESSENTIALS'.titleize, parent_id: home.id)
Job = Category.create(name: 'Job Work'.titleize, parent_id: home.id)
Quote = Category.create(name: 'Quote '.titleize, parent_id: home.id)

Wireless = Category.create(name: 'Wireless', parent_id: ESSENTIALS.id)
Internet = Category.create(name: 'Internet', parent_id: ESSENTIALS.id)
TV = Category.create(name: 'TV', parent_id: ESSENTIALS.id)
Home = Category.create(name: 'Home Phone', parent_id: ESSENTIALS.id)
Smart = Category.create(name: 'Smart Home Monitoring', parent_id: ESSENTIALS.id)
Heating = Category.create(name: 'Heating', parent_id: ESSENTIALS.id)
Airconditioning = Category.create(name: 'Airconditioning', parent_id: ESSENTIALS.id)

Care = Category.create(name: 'Care', parent_id: Job.id)
General = Category.create(name: 'General Cleaner', parent_id: Job.id)

Electrical = Category.create(name: 'Electrical', parent_id: Job.id)
Plumbing = Category.create(name: 'Plumbing', parent_id: Job.id)
Improvements = Category.create(name: 'Home Improvements', parent_id: Job.id)
HVAC = Category.create(name: 'HVAC', parent_id: Job.id)
Others = Category.create(name: 'Others', parent_id: Job.id)

Painter = Category.create(name: 'Painter', parent_id: Quote.id)
Handyman = Category.create(name: 'Handyman', parent_id: Quote.id)
Roofing = Category.create(name: 'Roofing', parent_id: Quote.id)
Carpenter = Category.create(name: 'Carpenter', parent_id: Quote.id)
Remodelling = Category.create(name: 'Remodelling & Rennovation', parent_id: Quote.id)
Basement = Category.create(name: 'Basement Finishing', parent_id: Quote.id)

Inside = Category.create(name: 'Home Inside', parent_id: Care.id)

Inspection = Category.create(name: 'Inspection', parent_id: General.id)
Installation = Category.create(name: 'Installation & Replacement', parent_id: General.id)
Repair = Category.create(name: 'Repair', parent_id: General.id)
Maintenance = Category.create(name: 'Maintenance', parent_id: General.id)
Emergency = Category.create(name: 'Emergency', parent_id: General.id)
Home = Category.create(name: 'Home Outdoor Care', parent_id: General.id)
GeneralCleaner = Category.create(name: 'General Cleaner', parent_id: General.id)

Certified = Category.create(name: 'Certified electrician', parent_id: Electrical.id)
ElectricalInspection = Category.create(name: 'Inspection', parent_id: Electrical.id)
ElectricalInstallation = Category.create(name: 'Installation & Replacement', parent_id: Electrical.id)
ElectricalRepair = Category.create(name: 'Repair ', parent_id: Electrical.id)
ElectricalMaintenance = Category.create(name: 'Maintenance', parent_id: Electrical.id)

PlumberGeneral = Category.create(name: 'General Plumber', parent_id: Plumbing.id)
PlumberInspection = Category.create(name: 'Inspection', parent_id: Plumbing.id)
PlumberInstallation = Category.create(name: 'Installation & Replacement', parent_id: Plumbing.id)
PlumberRepair = Category.create(name: 'Repair', parent_id: Plumbing.id)
PlumberMaintenance = Category.create(name: 'Maintenance', parent_id: Plumbing.id)
PlumberEmergency = Category.create(name: 'Emergency', parent_id: Plumbing.id)

ImprovementsInstallation = Category.create(name: 'Installation & Replacement', parent_id: Improvements.id)
ImprovementsRepair = Category.create(name: 'Repair', parent_id: Improvements.id)
ImprovementsMaintenance = Category.create(name: 'Maintenance', parent_id: Improvements.id)
ImprovementsEmergency = Category.create(name: 'Emergency', parent_id: Improvements.id)

HVACInstallation = Category.create(name: 'Installation & Replacement', parent_id: HVAC.id)
HVACRepair = Category.create(name: 'Repair', parent_id: HVAC.id)
HVACMaintenance = Category.create(name: 'Maintenance', parent_id: HVAC.id)
HVACEmergency = Category.create(name: 'Emergency', parent_id: HVAC.id)

RemodellingKitchen = Category.create(name: 'Kitchen', parent_id: Remodelling.id)
RemodellingWashroom = Category.create(name: 'Washroom', parent_id: Remodelling.id)
RemodellingCounter = Category.create(name: 'Counter Tops', parent_id: Remodelling.id)
RemodellingDrywall = Category.create(name: 'Drywall Taping', parent_id: Remodelling.id)
RemodellingInterior = Category.create(name: 'Interior Redisgning', parent_id: Remodelling.id)

Category.create(name: 'Chimney Inspection', parent_id: Inspection.id)

Category.create(name: 'Attic Fan Installation', parent_id: Installation.id)
Category.create(name: 'Chimney', parent_id: Installation.id)
Category.create(name: 'Outdoor Fencing', parent_id: Installation.id)
Category.create(name: 'Shed', parent_id: Installation.id)
Category.create(name: 'Lawn Sprinkler and Irrigation System', parent_id: Installation.id)

Category.create(name: 'Deep cleaning of Cabinets', parent_id: Maintenance.id)
Category.create(name: 'Bathroom Cleaning', parent_id: Maintenance.id)
Category.create(name: 'Carpet Cleaning', parent_id: Maintenance.id)
Category.create(name: 'Duct Cleaning', parent_id: Maintenance.id)
Category.create(name: 'General Room Cleaning', parent_id: Maintenance.id)
Category.create(name: 'Kitchen Cleaning', parent_id: Maintenance.id)
Category.create(name: 'Pest Control', parent_id: Maintenance.id)
Category.create(name: 'Hardwood Cleaning', parent_id: Maintenance.id)
Category.create(name: 'Window Cleaning', parent_id: Maintenance.id)
Category.create(name: 'Chimney Cleaning ', parent_id: Maintenance.id)

Category.create(name: 'Lawn Mowing', parent_id: Maintenance.id)
Category.create(name: 'Grass cutting', parent_id: Maintenance.id)
Category.create(name: 'Fertilizers', parent_id: Maintenance.id)
Category.create(name: 'Weed Control', parent_id: Maintenance.id)
Category.create(name: 'Outdoor Pest Control', parent_id: Maintenance.id)
Category.create(name: 'Tree Cutting', parent_id: Maintenance.id)
Category.create(name: 'Yard Cleaning', parent_id: Maintenance.id)
Category.create(name: 'Trash Removal', parent_id: Maintenance.id)
Category.create(name: 'High Pressure Wash', parent_id: Maintenance.id)
Category.create(name: 'Backyard Cleaning', parent_id: Maintenance.id)

Category.create(name: 'Outdoor Fence', parent_id: Repair.id)
Category.create(name: 'Paveway and Concrete', parent_id: Repair.id)
Category.create(name: 'Shed', parent_id: Repair.id)

Category.create(name: 'Ice Removal', parent_id: Emergency.id)
Category.create(name: 'Dead Animal Removal', parent_id: Emergency.id)

Category.create(name: 'Electrical Wiring', parent_id: ElectricalInstallation.id)
Category.create(name: 'Panel Inspection', parent_id: ElectricalInstallation.id)
Category.create(name: 'General Inspection', parent_id: ElectricalInstallation.id)

['Appliance Install ', 'Bathroom Fans', 'Attic Fan', 'Electric Circuit Breaker', 'Garage Door Opener', 'Chandelior Installation', 'Pot Lights '].each do |cat|
  Category.create(name: cat, parent_id: ElectricalInstallation.id)
end

['General Repairs', 'Appliance Repair', 'Garage Door Opener'].each do |cat|
  Category.create(name: cat, parent_id: ElectricalRepair.id)
end

['Appliance Cleaning '].each do |cat|
  Category.create(name: cat, parent_id: ElectricalMaintenance.id)
end

['Water Pipeline', 'Drainage System', 'Main Sewer Video Camera Pipe Inspection'].each do |cat|
  Category.create(name: cat, parent_id: PlumberInspection.id)
end

['Drainage System', 'General Cleaning', 'Main sewer Cleaning', 'Water Leak Treatment'].each do |cat|
  Category.create(name: cat, parent_id: PlumberMaintenance.id)
end

['Clogged Drains', 'Water Leakage'].each do |cat|
  Category.create(name: cat, parent_id: PlumberEmergency.id)
end

['Camera & Security Systems', 'Windows and Doors', 'Fireplace ', 'Carpeting', 'Flooring', 'TV Wall Mounting', 'Sound Bar Installation', 'Home Theatre', 'Home Audio Setup', 'Projector Mounting', 'Patio', 'General Assembler'].each do |cat|
  Category.create(name: cat, parent_id: ImprovementsInstallation.id)
end
# Seed Data for Time Schema
TimeSchema.delete_all
60.step(by: 60, to: 10_080).each do |time|
  diff_time = "#{Time.at(((time - 60) % 1440 * 60)).utc.strftime('%H:%M:%S')} - #{Time.at((time % 1440 * 60)).utc.strftime('%H:%M:%S')}"
  TimeSchema.create(day_name: Date::DAYNAMES[((time - 1) / 1440)], time_value: time, time_name: diff_time)
end

AreaOfService.delete_all

%w[Ajax Clarington Brock Oshawa Pickering Scugog Uxbridge Whitby].each do |city|
  AreaOfService.create(name: city, region: 'Durham')
end
%w[Burlington Halton Hills Milton Oakville].each do |city|
  AreaOfService.create(name: city, region: 'Halton')
end
%w[Brampton Caledon Mississauga].each do |city|
  AreaOfService.create(name: city, region: 'Peel')
end
%w[Aurora East Gwillimbury Georgina King Markham Newmarket Richmond Hill Vaughan Whitchurch-Stouffville].each do |city|
  AreaOfService.create(name: city, region: 'York')
end

["Television", "TV", "Home Phone", "SHM"].each do |cat|
  c = Category.create(name: cat)
  listing = Listing.create!(category: c, description: cat)

end
listing = Listing.find_by(description: 'Television')
["internet_provider", "internet_download_speed", "internet_upload_speed", "usage"].each do |attr|
  ListingAttribute.create!(listing_id: listing.id, attribute_name: attr)
end

listing = Listing.find_by(description: 'TV')
["TV_Provider", "private_recording", "additional_tv", "tv_options_basic", "tv_options_kids", "tv_options_sports", "tv_options_movies", "hp_options_gta"].each do |attr|
  ListingAttribute.create!(listing_id: listing.id, attribute_name: attr)
end

listing = Listing.find_by(description: 'Home Phone')
['hm_rovider', "hp_options_naca", "hp_options_international"].each do |attr|
  ListingAttribute.create!(listing_id: listing.id, attribute_name: attr)
end

listing = Listing.find_by(description: 'SHM')
['shm_provider', 'monitoring_cameras', 'door_window_sensors', 'automatic_door_lock', 'motion_sensors'].each do |attr|
  ListingAttribute.create!(listing_id: listing.id, attribute_name: attr)
end

