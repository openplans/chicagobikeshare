sudo "monit -g dj_chicagobikeshare restart all"
on_app_master do
  sudo "#{current_path}/deploy/postgis_setup.sh"
end
