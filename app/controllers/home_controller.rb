# -*- coding: utf-8 -*-
class HomeController < ApplicationController
  
  def index
    if params[:starting_date].present? && params[:add_no].present? && params[:add_what].present?
      @add_result = adding(params[:starting_date], params[:add_no], params[:add_what])    
    elsif params[:convert_what].present? &&  params[:c_date].present?
      @convert_result = converting(params[:convert_what].to_i, params[:c_date])
    end
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def converting(c_what,c_date)
    c_date = prepare_date(c_date)
    case c_what
    when 1
      HijriUmmAlqura.gd_to_hd(c_date[0],c_date[1], c_date[2])
    when 2
      HijriUmmAlqura.hd_to_gd(c_date[0],c_date[1], c_date[2])
    end
  end
    
  def adding(s_date, a_no, a_what)
    starting_date = prepare_date(s_date)
    add_what = a_what.to_s.strip
    add_no = a_no.to_i
    hijri_date = HijriUmmAlqura::Hijri.new(starting_date[0],starting_date[1], starting_date[2])
    case add_what.to_i
    when 1
      hijri_date.add(add_no,'d')
    when 2
      hijri_date.add(add_no,'w')
    when 3
      hijri_date.add(add_no,'m')
    when 4
      hijri_date.add(add_no,'y')
    end
  end

  def prepare_date(input)
    input.to_s.split('-').collect {|d| d.to_i}
  end
    
end
  
