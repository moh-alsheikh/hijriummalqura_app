# -*- coding: utf-8 -*-

#============================================================================================================
# :: Deafult Setting for hijri calendar ::
#============================================================================================================

$jdepoch = 1948439.5

$name = 'Islamic'

$currentText = 'الحالي'

$epochs = ['BAM', 'AM']

$monthNames = ['محرّم', 'صفر', 'ربيع الأول', 'ربيع الثاني', 'جمادى الاول', 'جمادى الثاني',	'رجب', 'شعبان', 'رمضان', 'شوّال', 'ذو القعدة', 'ذو الحجة']

$monthNamesShort = ['محرّم', 'صفر', 'ربيع الأول', 'ربيع الثاني', 'جمادى الاول', 'جمادى الثاني',	'رجب', 'شعبان', 'رمضان', 'شوّال', 'ذو القعدة', 'ذو الحجة']

$dayNames = [' الأحد', ' الإثنين', ' الثلاثاء', ' الأربعاء', ' الخميس', ' الجمعة', ' السبت']

$dayNamesShort = [' الأحد', ' الإثنين', ' الثلاثاء', ' الأربعاء', ' الخميس', ' الجمعة', ' السبت']

$dayNamesMin = [' الأحد', ' الإثنين', ' الثلاثاء', ' الأربعاء', ' الخميس', ' الجمعة', ' السبت']

$dateFormat = 'yyyy-mm-dd'

$firstDay = 6

$isRTL = true 

$validateLevel = 0

#============================================================================================================
#============================================================================================================

module HijriHelp

=begin
============================================================================================================
implimintation of the Gregorian calendar
============================================================================================================
=end

##########################################################
# From Julian  To Gregorian Date
##########################################################

def fromjdtog(jd)

	z = (jd + 0.5).floor
	a = ((z - 1867216.25) / 36524.25).floor
	a = z + 1 + a -(a / 4).floor
	b = a + 1524
	c = ((b - 122.1) / 365.25).floor
	d = (365.25 * c).floor
	e = ((b - d) / 30.6001).floor
	day = b - d - (e * 30.6001).floor
	month = e - (e > 13.5 ? 13 : 1)
	year = c - (month > 2.5 ? 4716 : 4715)


	#	if (year <= 0) { year--; } // No year zero

	if year <= 0 

		year = 1

	end

	return year, month, day

end

##########################################################
# From  Gregorian Date To Julian 
##########################################################

def gtojd(year, month, day)

	#if (year < 0) { year++; } // No year zero

	if ( year < 0 )

		year = 1

	end	


	if ( month < 3 ) 

		month = month + 12
		year = year - 1 

	end

	a = (year / 100).floor

	b = 2 - a + (a / 4).floor

	return (365.25 * (year + 4716)).floor + (30.6001 * (month + 1)).floor + day + b - 1524.5

end

=begin
========================================================================
Gregorian calendar	##  Extra Functions
========================================================================
=end

#>>>>>>>>>>>>>>>>>>#>>>>>>>>>>>>>>>>>>#>>>>>>>>>>>>>>>>>>#>>>>>>>>>>>>>>>>>>
# => 											ADD DAYS TO HIJRI DATE	
#>>>>>>>>>>>>>>>>>>#>>>>>>>>>>>>>>>>>>#>>>>>>>>>>>>>>>>>>#>>>>>>>>>>>>>>>>>>

def add_days(year, month, day , offest )


	### From Hijri to Julian to  Gregorian date 

	gd = fromjdtog(islamictojd(year.to_i, month.to_i, day.to_i))

	### Add months to Gregorian date 

	parsed_date = Date.new( gd[0] , gd[1] , gd[2])  

	gd_after_add = parsed_date + offest

	gd_after_add = gd_after_add.to_s(:db)

	### From Gregorian to Julian to  Hijri date 	

	hd_after_add = fromjdtoislamic(gtojd(gd_after_add[0,4].to_i,gd_after_add[5,2].to_i,gd_after_add[8,2].to_i))

	##  Return Hijri date 

	#return year.to_s + '-' + month.to_s + '-' + day.to_s + ' بعد اضافة ' +  offest.to_s  + ' شهر  ' + hd_after_add.to_s

	return hd_after_add

end

#>>>>>>>>>>>>>>>>>>#>>>>>>>>>>>>>>>>>>#>>>>>>>>>>>>>>>>>>#>>>>>>>>>>>>>>>>>>
# => 											ADD MONTHS TO HIJRI DATE	
#>>>>>>>>>>>>>>>>>>#>>>>>>>>>>>>>>>>>>#>>>>>>>>>>>>>>>>>>#>>>>>>>>>>>>>>>>>>

def add_months(year, month, day , offest )


	### From Hijri to Julian to  Gregorian date 

	gd = fromjdtog(islamictojd(year.to_i, month.to_i, day.to_i))

	### Add months to Gregorian date 

	parsed_date = Date.new( gd[0] , gd[1] , gd[2])  

	gd_after_add = parsed_date.months_since(offest)

	gd_after_add = gd_after_add.to_s(:db)

	### From Gregorian to Julian to  Hijri date 	

	hd_after_add = fromjdtoislamic(gtojd(gd_after_add[0,4].to_i,gd_after_add[5,2].to_i,gd_after_add[8,2].to_i))

	##  Return Hijri date 

	#return year.to_s + '-' + month.to_s + '-' + day.to_s + ' بعد اضافة ' +  offest.to_s  + ' شهر  ' + hd_after_add.to_s

	return hd_after_add

end

#>>>>>>>>>>>>>>>>>>#>>>>>>>>>>>>>>>>>>#>>>>>>>>>>>>>>>>>>#>>>>>>>>>>>>>>>>>>
# => 											ADD YEARS TO HIJRI DATE	
#>>>>>>>>>>>>>>>>>>#>>>>>>>>>>>>>>>>>>#>>>>>>>>>>>>>>>>>>#>>>>>>>>>>>>>>>>>>

def add_years(year, month, day , offest )

	### From Hijri to Julian to  Gregorian date 

	gd = fromjdtog(islamictojd(year.to_i, month.to_i, day.to_i))

	### Add months to Gregorian date 

	parsed_date = Date.new( gd[0] , gd[1] , gd[2])  

	gd_after_add = parsed_date.years_since(offest)

	gd_after_add = gd_after_add.to_s(:db)

	### From Gregorian to Julian to  Hijri date 	

	hd_after_add = fromjdtoislamic(gtojd(gd_after_add[0,4].to_i,gd_after_add[5,2].to_i,gd_after_add[8,2].to_i))

	##  Return Hijri date 

	#return year.to_s + '-' + month.to_s + '-' + day.to_s + ' بعد اضافة ' +  offest.to_s  + ' شهر  ' + hd_after_add.to_s

	return hd_after_add

end

#=============================#=============================#================
#=============================#=============================#================

=begin
============================================================================================================
implimintation of the Islamic calendar
============================================================================================================
=end

##########################################################
# From Julian  To Islamic Date
##########################################################

def fromjdtoislamic(jd)

	jd = (jd).floor + 0.5

	year = ((30 * (jd - $jdepoch) + 10646) / 10631).floor

	#year = (year <= 0 ? year - 1 : year)

	if ( year < 0 )

		year = -1

	end

	month = [12, ((jd - 29 - islamictojd(year, 1, 1)) / 29.5).ceil + 1].min

	day = (jd - islamictojd(year, month, 1) + 1).to_i

	return year, month, day

end

##########################################################
# From  Islamic Date To Julian 
##########################################################

def islamictojd(year, month, day)

	#	year = (year <= 0 ? year + 1 : year)

	if ( year < 0 )

		year = 1

	end

	return day + (29.5 * (month - 1)).ceil + (year - 1) * 354 + ((3 + (11 * year)) / 30).floor + $jdepoch - 1

end

end
