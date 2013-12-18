# -*- coding: utf-8 -*-
module ApplicationHelper  
    def hijri_date
      HijriUmmAlqura::Hijri.new
    end
end
