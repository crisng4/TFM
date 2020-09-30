libname datos 'C:\Users\cris\Documents\TFM';
/*********************************************************VARIABLES ORIGINALES********************************************************/
proc print data=datos.variables_originales_train;run;
data=datos.variables_originales_train;run;

/*STEPWISE*/
%macro randomselect(data=,listclass=,vardepen=,modelo=,criterio=,sinicio=,sfinal=,fracciontrain=,directorio=&directorio); 
options nocenter linesize=256;
proc printto print="&directorio\kk.txt";run;
data _null_;file "&directorio\cosa.txt" linesize=2000;run;
%do semilla=&sinicio %to &sfinal;
proc surveyselect data=&data rate=&fracciontrain out=sal1234 seed=&semilla;run;
ods output   SelectionSummary=modelos;
ods output    SelectedEffects=efectos;
ods output    Glmselect.SelectedModel.FitStatistics=ajuste;
proc glmselect data=sal1234  plots=all seed=&semilla;
  class &listclass; 
  model &vardepen= &modelo/ selection=stepwise(select=&criterio choose=&criterio) details=all stats=all;
run;   
ods graphics off;   
ods html close;   
data union;i=5;set efectos;set ajuste point=i;run;
data _null_;semilla=&semilla;file "&directorio\cosa.txt" mod linesize=2000;set union;put effects ;run;
%end;
proc printto ;run;
data todos;
infile "&directorio\cosa.txt" linesize=2000;
length efecto $ 1000;
input efecto @@;
if efecto ne 'Intercept' then output;
run;
proc freq data=todos;tables efecto /out=sal;run;
proc sort data=sal;by descending count;
proc print data=sal;run;

data todos;
infile "&directorio\cosa.txt" linesize=2000;
length efecto $ 1000;
input efecto $ &&;
run;
proc freq data=todos;tables efecto /out=salefec;run;
proc sort data=salefec;by descending count;
proc print data=salefec;run;
data _null_;set salefec;put efecto;run;
%mend;

%randomselect(data=datos.variables_originales_train,
listclass=REP_disc_number_track album_type explicit_track,
vardepen=popularity_track,
modelo=REP_disc_number_track album_type explicit_track acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_max_track key_mean_track key_min_track key_track liveness_track 
loudness_max_track loudness_mean_track loudness_min_track loudness_track mode_max_track mode_mean_track mode_min_track mode_track speechiness_track tempo_max_track tempo_mean_track tempo_min_track tempo_track time_signature_max_track time_signature_mean_track time_signature_min_track time_signature_track total_followers_artist total_tracks_album track_number_track valence_track,
criterio=AIC,
sinicio=12345,
sfinal=12445,
fracciontrain=0.8, directorio=C:\Users\cris\Documents\TFM);
proc print data="hola";run;
proc copy inlib=work outlib=datos ;
select salefec;
run;
%randomselect(data=datos.variables_originales_train,
listclass=REP_disc_number_track album_type explicit_track,
vardepen=popularity_track,
modelo=REP_disc_number_track album_type explicit_track acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_max_track key_mean_track key_min_track key_track liveness_track 
loudness_max_track loudness_mean_track loudness_min_track loudness_track mode_max_track mode_mean_track mode_min_track mode_track speechiness_track tempo_max_track tempo_mean_track tempo_min_track tempo_track time_signature_max_track time_signature_mean_track time_signature_min_track time_signature_track total_followers_artist total_tracks_album track_number_track valence_track,
criterio=BIC,
sinicio=12345,
sfinal=12445,
fracciontrain=0.8, directorio=C:\Users\cris\Documents\TFM);
proc print data="hola";run;
proc copy inlib=work outlib=datos ;
select salefec;
run;
%randomselect(data=datos.variables_originales_train,
listclass=REP_disc_number_track album_type explicit_track,
vardepen=popularity_track,
modelo=REP_disc_number_track album_type explicit_track acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_max_track key_mean_track key_min_track key_track liveness_track 
loudness_max_track loudness_mean_track loudness_min_track loudness_track mode_max_track mode_mean_track mode_min_track mode_track speechiness_track tempo_max_track tempo_mean_track tempo_min_track tempo_track time_signature_max_track time_signature_mean_track time_signature_min_track time_signature_track total_followers_artist total_tracks_album track_number_track valence_track,
criterio=SBC,
sinicio=12345,
sfinal=12445,
fracciontrain=0.8, directorio=C:\Users\cris\Documents\TFM);
proc print data="hola";run;
proc copy inlib=work outlib=datos ;
select salefec;
run;


/*BACKWARD*/
%macro randomselect(data=,listclass=,vardepen=,modelo=,criterio=,sinicio=,sfinal=,fracciontrain=,directorio=&directorio); 
options nocenter linesize=256;
proc printto print="&directorio\kk.txt";run;
data _null_;file "&directorio\cosa.txt" linesize=2000;run;
%do semilla=&sinicio %to &sfinal;
proc surveyselect data=&data rate=&fracciontrain out=sal1234 seed=&semilla;run;
ods output   SelectionSummary=modelos;
ods output    SelectedEffects=efectos;
ods output    Glmselect.SelectedModel.FitStatistics=ajuste;
proc glmselect data=sal1234  plots=all seed=&semilla;
  class &listclass; 
  model &vardepen= &modelo/ selection=backward(select=&criterio choose=&criterio) details=all stats=all;
run;   
ods graphics off;   
ods html close;   
data union;i=5;set efectos;set ajuste point=i;run;
data _null_;semilla=&semilla;file "&directorio\cosa.txt" mod linesize=2000;set union;put effects ;run;
%end;
proc printto ;run;
data todos;
infile "&directorio\cosa.txt" linesize=2000;
length efecto $ 1000;
input efecto @@;
if efecto ne 'Intercept' then output;
run;
proc freq data=todos;tables efecto /out=sal;run;
proc sort data=sal;by descending count;
proc print data=sal;run;

data todos;
infile "&directorio\cosa.txt" linesize=2000;
length efecto $ 1000;
input efecto $ &&;
run;
proc freq data=todos;tables efecto /out=salefec;run;
proc sort data=salefec;by descending count;
proc print data=salefec;run;
data _null_;set salefec;put efecto;run;
%mend;

%randomselect(data=datos.variables_originales_train,
listclass=REP_disc_number_track album_type explicit_track,
vardepen=popularity_track,
modelo=REP_disc_number_track album_type explicit_track acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_max_track key_mean_track key_min_track key_track liveness_track 
loudness_max_track loudness_mean_track loudness_min_track loudness_track mode_max_track mode_mean_track mode_min_track mode_track speechiness_track tempo_max_track tempo_mean_track tempo_min_track tempo_track time_signature_max_track time_signature_mean_track time_signature_min_track time_signature_track total_followers_artist total_tracks_album track_number_track valence_track,
criterio=AIC,
sinicio=12345,
sfinal=12445,
fracciontrain=0.8, directorio=C:\Users\cris\Documents\TFM);
proc print data="hola";run;
proc copy inlib=work outlib=datos ;
select salefec;
run;
%randomselect(data=datos.variables_originales_train,
listclass=REP_disc_number_track album_type explicit_track,
vardepen=popularity_track,
modelo=REP_disc_number_track album_type explicit_track acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_max_track key_mean_track key_min_track key_track liveness_track 
loudness_max_track loudness_mean_track loudness_min_track loudness_track mode_max_track mode_mean_track mode_min_track mode_track speechiness_track tempo_max_track tempo_mean_track tempo_min_track tempo_track time_signature_max_track time_signature_mean_track time_signature_min_track time_signature_track total_followers_artist total_tracks_album track_number_track valence_track,
criterio=BIC,
sinicio=12345,
sfinal=12445,
fracciontrain=0.8, directorio=C:\Users\cris\Documents\TFM);
proc print data="hola";run;
proc copy inlib=work outlib=datos ;
select salefec;
run;
%randomselect(data=datos.variables_originales_train,
listclass=REP_disc_number_track album_type explicit_track,
vardepen=popularity_track,
modelo=REP_disc_number_track album_type explicit_track acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_max_track key_mean_track key_min_track key_track liveness_track 
loudness_max_track loudness_mean_track loudness_min_track loudness_track mode_max_track mode_mean_track mode_min_track mode_track speechiness_track tempo_max_track tempo_mean_track tempo_min_track tempo_track time_signature_max_track time_signature_mean_track time_signature_min_track time_signature_track total_followers_artist total_tracks_album track_number_track valence_track,
criterio=SBC,
sinicio=12345,
sfinal=12445,
fracciontrain=0.8, directorio=C:\Users\cris\Documents\TFM);
proc print data="hola";run;
proc copy inlib=work outlib=datos ;
select salefec;
run;

/*FORWARD*/
%macro randomselect(data=,listclass=,vardepen=,modelo=,criterio=,sinicio=,sfinal=,fracciontrain=,directorio=&directorio); 
options nocenter linesize=256;
proc printto print="&directorio\kk.txt";run;
data _null_;file "&directorio\cosa.txt" linesize=2000;run;
%do semilla=&sinicio %to &sfinal;
proc surveyselect data=&data rate=&fracciontrain out=sal1234 seed=&semilla;run;
ods output   SelectionSummary=modelos;
ods output    SelectedEffects=efectos;
ods output    Glmselect.SelectedModel.FitStatistics=ajuste;
proc glmselect data=sal1234  plots=all seed=&semilla;
  class &listclass; 
  model &vardepen= &modelo/ selection=forward(select=&criterio choose=&criterio) details=all stats=all;
run;   
ods graphics off;   
ods html close;   
data union;i=5;set efectos;set ajuste point=i;run;
data _null_;semilla=&semilla;file "&directorio\cosa.txt" mod linesize=2000;set union;put effects ;run;
%end;
proc printto ;run;
data todos;
infile "&directorio\cosa.txt" linesize=2000;
length efecto $ 1000;
input efecto @@;
if efecto ne 'Intercept' then output;
run;
proc freq data=todos;tables efecto /out=sal;run;
proc sort data=sal;by descending count;
proc print data=sal;run;

data todos;
infile "&directorio\cosa.txt" linesize=2000;
length efecto $ 1000;
input efecto $ &&;
run;
proc freq data=todos;tables efecto /out=salefec;run;
proc sort data=salefec;by descending count;
proc print data=salefec;run;
data _null_;set salefec;put efecto;run;
%mend;

%randomselect(data=datos.variables_originales_train,
listclass=REP_disc_number_track album_type explicit_track,
vardepen=popularity_track,
modelo=REP_disc_number_track album_type explicit_track acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_max_track key_mean_track key_min_track key_track liveness_track 
loudness_max_track loudness_mean_track loudness_min_track loudness_track mode_max_track mode_mean_track mode_min_track mode_track speechiness_track tempo_max_track tempo_mean_track tempo_min_track tempo_track time_signature_max_track time_signature_mean_track time_signature_min_track time_signature_track total_followers_artist total_tracks_album track_number_track valence_track,
criterio=AIC,
sinicio=12345,
sfinal=12445,
fracciontrain=0.8, directorio=C:\Users\cris\Documents\TFM);
proc print data="hola";run;
proc copy inlib=work outlib=datos ;
select salefec;
run;
%randomselect(data=datos.variables_originales_train,
listclass=REP_disc_number_track album_type explicit_track,
vardepen=popularity_track,
modelo=REP_disc_number_track album_type explicit_track acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_max_track key_mean_track key_min_track key_track liveness_track 
loudness_max_track loudness_mean_track loudness_min_track loudness_track mode_max_track mode_mean_track mode_min_track mode_track speechiness_track tempo_max_track tempo_mean_track tempo_min_track tempo_track time_signature_max_track time_signature_mean_track time_signature_min_track time_signature_track total_followers_artist total_tracks_album track_number_track valence_track,
criterio=BIC,
sinicio=12345,
sfinal=12445,
fracciontrain=0.8, directorio=C:\Users\cris\Documents\TFM);
proc print data="hola";run;
proc copy inlib=work outlib=datos ;
select salefec;
run;
%randomselect(data=datos.variables_originales_train,
listclass=REP_disc_number_track album_type explicit_track,
vardepen=popularity_track,
modelo=REP_disc_number_track album_type explicit_track acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_max_track key_mean_track key_min_track key_track liveness_track 
loudness_max_track loudness_mean_track loudness_min_track loudness_track mode_max_track mode_mean_track mode_min_track mode_track speechiness_track tempo_max_track tempo_mean_track tempo_min_track tempo_track time_signature_max_track time_signature_mean_track time_signature_min_track time_signature_track total_followers_artist total_tracks_album track_number_track valence_track,
criterio=SBC,
sinicio=12345,
sfinal=12445,
fracciontrain=0.8, directorio=C:\Users\cris\Documents\TFM);
proc print data="hola";run;
proc copy inlib=work outlib=datos ;
select salefec;
run;





/*********************************************************VARIABLES TRANSFORMADAS********************************************************/
proc print data=datos.variables_transformadas_train;run;
data=datos.variables_transformadas_train;run;

/*STEPWISE*/
%macro randomselect(data=,listclass=,vardepen=,modelo=,criterio=,sinicio=,sfinal=,fracciontrain=,directorio=&directorio); 
options nocenter linesize=256;
proc printto print="&directorio\kk.txt";run;
data _null_;file "&directorio\cosa.txt" linesize=2000;run;
%do semilla=&sinicio %to &sfinal;
proc surveyselect data=&data rate=&fracciontrain out=sal1234 seed=&semilla;run;
ods output   SelectionSummary=modelos;
ods output    SelectedEffects=efectos;
ods output    Glmselect.SelectedModel.FitStatistics=ajuste;
proc glmselect data=sal1234  plots=all seed=&semilla;
  class &listclass; 
  model &vardepen= &modelo/ selection=stepwise(select=&criterio choose=&criterio) details=all stats=all;
run;   
ods graphics off;   
ods html close;   
data union;i=5;set efectos;set ajuste point=i;run;
data _null_;semilla=&semilla;file "&directorio\cosa.txt" mod linesize=2000;set union;put effects ;run;
%end;
proc printto ;run;
data todos;
infile "&directorio\cosa.txt" linesize=2000;
length efecto $ 1000;
input efecto @@;
if efecto ne 'Intercept' then output;
run;
proc freq data=todos;tables efecto /out=sal;run;
proc sort data=sal;by descending count;
proc print data=sal;run;

data todos;
infile "&directorio\cosa.txt" linesize=2000;
length efecto $ 1000;
input efecto $ &&;
run;
proc freq data=todos;tables efecto /out=salefec;run;
proc sort data=salefec;by descending count;
proc print data=salefec;run;
data _null_;set salefec;put efecto;run;
%mend;

%randomselect(data=datos.variables_transformadas_train,
listclass=REP_disc_number_track album_type explicit_track,
vardepen=popularity_track,
modelo=REP_disc_number_track album_type explicit_track EXP_key_min_track EXP_loudness_mean_track EXP_mode_max_track EXP_mode_track LOG_speechiness_track LOG_tempo_mean_track LOG_tempo_min_track LOG_total_followers_artist
LOG_valence_track PWR_danceability_track PWR_key_mean_track PWR_key_track PWR_loudness_max_track PWR_loudness_min_track PWR_loudness_track PWR_tempo_track 
PWR_time_signature_max_track PWR_time_signature_min_track SQRT_energy_track SQRT_instrumentalness_track SQRT_liveness_track SQRT_total_tracks_album SQR_mode_mean_track
SQR_mode_min_track acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_max_track key_mean_track key_min_track key_track
liveness_track loudness_max_track loudness_mean_track loudness_min_track loudness_track mode_max_track mode_mean_track mode_min_track mode_track speechiness_track
tempo_max_track tempo_mean_track tempo_min_track tempo_track time_signature_max_track time_signature_mean_track time_signature_min_track time_signature_track
total_followers_artist total_tracks_album track_number_track valence_track,
criterio=AIC,
sinicio=12345,
sfinal=12445,
fracciontrain=0.8, directorio=C:\Users\cris\Documents\TFM);
proc print data="hola";run;
proc copy inlib=work outlib=datos ;
select salefec;
run;
%randomselect(data=datos.variables_transformadas_train,
listclass=REP_disc_number_track album_type explicit_track,
vardepen=popularity_track,
modelo=REP_disc_number_track album_type explicit_track EXP_key_min_track EXP_loudness_mean_track EXP_mode_max_track EXP_mode_track LOG_speechiness_track LOG_tempo_mean_track LOG_tempo_min_track LOG_total_followers_artist
LOG_valence_track PWR_danceability_track PWR_key_mean_track PWR_key_track PWR_loudness_max_track PWR_loudness_min_track PWR_loudness_track PWR_tempo_track 
PWR_time_signature_max_track PWR_time_signature_min_track SQRT_energy_track SQRT_instrumentalness_track SQRT_liveness_track SQRT_total_tracks_album SQR_mode_mean_track
SQR_mode_min_track acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_max_track key_mean_track key_min_track key_track
liveness_track loudness_max_track loudness_mean_track loudness_min_track loudness_track mode_max_track mode_mean_track mode_min_track mode_track speechiness_track
tempo_max_track tempo_mean_track tempo_min_track tempo_track time_signature_max_track time_signature_mean_track time_signature_min_track time_signature_track
total_followers_artist total_tracks_album track_number_track valence_track,
criterio=BIC,
sinicio=12345,
sfinal=12445,
fracciontrain=0.8, directorio=C:\Users\cris\Documents\TFM);
proc print data="hola";run;
proc copy inlib=work outlib=datos ;
select salefec;
run;
%randomselect(data=datos.variables_transformadas_train,
listclass=REP_disc_number_track album_type explicit_track,
vardepen=popularity_track,
modelo=REP_disc_number_track album_type explicit_track EXP_key_min_track EXP_loudness_mean_track EXP_mode_max_track EXP_mode_track LOG_speechiness_track LOG_tempo_mean_track LOG_tempo_min_track LOG_total_followers_artist
LOG_valence_track PWR_danceability_track PWR_key_mean_track PWR_key_track PWR_loudness_max_track PWR_loudness_min_track PWR_loudness_track PWR_tempo_track 
PWR_time_signature_max_track PWR_time_signature_min_track SQRT_energy_track SQRT_instrumentalness_track SQRT_liveness_track SQRT_total_tracks_album SQR_mode_mean_track
SQR_mode_min_track acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_max_track key_mean_track key_min_track key_track
liveness_track loudness_max_track loudness_mean_track loudness_min_track loudness_track mode_max_track mode_mean_track mode_min_track mode_track speechiness_track
tempo_max_track tempo_mean_track tempo_min_track tempo_track time_signature_max_track time_signature_mean_track time_signature_min_track time_signature_track
total_followers_artist total_tracks_album track_number_track valence_track,
criterio=SBC,
sinicio=12345,
sfinal=12445,
fracciontrain=0.8, directorio=C:\Users\cris\Documents\TFM);
proc print data="hola";run;
proc copy inlib=work outlib=datos ;
select salefec;
run;


/*BACKWARD*/
%macro randomselect(data=,listclass=,vardepen=,modelo=,criterio=,sinicio=,sfinal=,fracciontrain=,directorio=&directorio); 
options nocenter linesize=256;
proc printto print="&directorio\kk.txt";run;
data _null_;file "&directorio\cosa.txt" linesize=2000;run;
%do semilla=&sinicio %to &sfinal;
proc surveyselect data=&data rate=&fracciontrain out=sal1234 seed=&semilla;run;
ods output   SelectionSummary=modelos;
ods output    SelectedEffects=efectos;
ods output    Glmselect.SelectedModel.FitStatistics=ajuste;
proc glmselect data=sal1234  plots=all seed=&semilla;
  class &listclass; 
  model &vardepen= &modelo/ selection=backward(select=&criterio choose=&criterio) details=all stats=all;
run;   
ods graphics off;   
ods html close;   
data union;i=5;set efectos;set ajuste point=i;run;
data _null_;semilla=&semilla;file "&directorio\cosa.txt" mod linesize=2000;set union;put effects ;run;
%end;
proc printto ;run;
data todos;
infile "&directorio\cosa.txt" linesize=2000;
length efecto $ 1000;
input efecto @@;
if efecto ne 'Intercept' then output;
run;
proc freq data=todos;tables efecto /out=sal;run;
proc sort data=sal;by descending count;
proc print data=sal;run;

data todos;
infile "&directorio\cosa.txt" linesize=2000;
length efecto $ 1000;
input efecto $ &&;
run;
proc freq data=todos;tables efecto /out=salefec;run;
proc sort data=salefec;by descending count;
proc print data=salefec;run;
data _null_;set salefec;put efecto;run;
%mend;

%randomselect(data=datos.variables_transformadas_train,
listclass=REP_disc_number_track album_type explicit_track,
vardepen=popularity_track,
modelo=REP_disc_number_track album_type explicit_track EXP_key_min_track EXP_loudness_mean_track EXP_mode_max_track EXP_mode_track LOG_speechiness_track LOG_tempo_mean_track LOG_tempo_min_track LOG_total_followers_artist
LOG_valence_track PWR_danceability_track PWR_key_mean_track PWR_key_track PWR_loudness_max_track PWR_loudness_min_track PWR_loudness_track PWR_tempo_track 
PWR_time_signature_max_track PWR_time_signature_min_track SQRT_energy_track SQRT_instrumentalness_track SQRT_liveness_track SQRT_total_tracks_album SQR_mode_mean_track
SQR_mode_min_track acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_max_track key_mean_track key_min_track key_track
liveness_track loudness_max_track loudness_mean_track loudness_min_track loudness_track mode_max_track mode_mean_track mode_min_track mode_track speechiness_track
tempo_max_track tempo_mean_track tempo_min_track tempo_track time_signature_max_track time_signature_mean_track time_signature_min_track time_signature_track
total_followers_artist total_tracks_album track_number_track valence_track,
criterio=AIC,
sinicio=12345,
sfinal=12445,
fracciontrain=0.8, directorio=C:\Users\cris\Documents\TFM);
proc print data="hola";run;
proc copy inlib=work outlib=datos ;
select salefec;
run;
%randomselect(data=datos.variables_transformadas_train,
listclass=REP_disc_number_track album_type explicit_track,
vardepen=popularity_track,
modelo=REP_disc_number_track album_type explicit_track EXP_key_min_track EXP_loudness_mean_track EXP_mode_max_track EXP_mode_track LOG_speechiness_track LOG_tempo_mean_track LOG_tempo_min_track LOG_total_followers_artist
LOG_valence_track PWR_danceability_track PWR_key_mean_track PWR_key_track PWR_loudness_max_track PWR_loudness_min_track PWR_loudness_track PWR_tempo_track 
PWR_time_signature_max_track PWR_time_signature_min_track SQRT_energy_track SQRT_instrumentalness_track SQRT_liveness_track SQRT_total_tracks_album SQR_mode_mean_track
SQR_mode_min_track acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_max_track key_mean_track key_min_track key_track
liveness_track loudness_max_track loudness_mean_track loudness_min_track loudness_track mode_max_track mode_mean_track mode_min_track mode_track speechiness_track
tempo_max_track tempo_mean_track tempo_min_track tempo_track time_signature_max_track time_signature_mean_track time_signature_min_track time_signature_track
total_followers_artist total_tracks_album track_number_track valence_track,
criterio=BIC,
sinicio=12345,
sfinal=12445,
fracciontrain=0.8, directorio=C:\Users\cris\Documents\TFM);
proc print data="hola";run;
proc copy inlib=work outlib=datos ;
select salefec;
run;
%randomselect(data=datos.variables_transformadas_train,
listclass=REP_disc_number_track album_type explicit_track,
vardepen=popularity_track,
modelo=REP_disc_number_track album_type explicit_track EXP_key_min_track EXP_loudness_mean_track EXP_mode_max_track EXP_mode_track LOG_speechiness_track LOG_tempo_mean_track LOG_tempo_min_track LOG_total_followers_artist
LOG_valence_track PWR_danceability_track PWR_key_mean_track PWR_key_track PWR_loudness_max_track PWR_loudness_min_track PWR_loudness_track PWR_tempo_track 
PWR_time_signature_max_track PWR_time_signature_min_track SQRT_energy_track SQRT_instrumentalness_track SQRT_liveness_track SQRT_total_tracks_album SQR_mode_mean_track
SQR_mode_min_track acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_max_track key_mean_track key_min_track key_track
liveness_track loudness_max_track loudness_mean_track loudness_min_track loudness_track mode_max_track mode_mean_track mode_min_track mode_track speechiness_track
tempo_max_track tempo_mean_track tempo_min_track tempo_track time_signature_max_track time_signature_mean_track time_signature_min_track time_signature_track
total_followers_artist total_tracks_album track_number_track valence_track,
criterio=SBC,
sinicio=12345,
sfinal=12445,
fracciontrain=0.8, directorio=C:\Users\cris\Documents\TFM);

proc copy inlib=work outlib=datos ;
select salefec;
run;

/*FORWARD*/
%macro randomselect(data=,listclass=,vardepen=,modelo=,criterio=,sinicio=,sfinal=,fracciontrain=,directorio=&directorio); 
options nocenter linesize=256;
proc printto print="&directorio\kk.txt";run;
data _null_;file "&directorio\cosa.txt" linesize=2000;run;
%do semilla=&sinicio %to &sfinal;
proc surveyselect data=&data rate=&fracciontrain out=sal1234 seed=&semilla;run;
ods output   SelectionSummary=modelos;
ods output    SelectedEffects=efectos;
ods output    Glmselect.SelectedModel.FitStatistics=ajuste;
proc glmselect data=sal1234  plots=all seed=&semilla;
  class &listclass; 
  model &vardepen= &modelo/ selection=forward(select=&criterio choose=&criterio) details=all stats=all;
run;   
ods graphics off;   
ods html close;   
data union;i=5;set efectos;set ajuste point=i;run;
data _null_;semilla=&semilla;file "&directorio\cosa.txt" mod linesize=2000;set union;put effects ;run;
%end;
proc printto ;run;
data todos;
infile "&directorio\cosa.txt" linesize=2000;
length efecto $ 1000;
input efecto @@;
if efecto ne 'Intercept' then output;
run;
proc freq data=todos;tables efecto /out=sal;run;
proc sort data=sal;by descending count;
proc print data=sal;run;

data todos;
infile "&directorio\cosa.txt" linesize=2000;
length efecto $ 1000;
input efecto $ &&;
run;
proc freq data=todos;tables efecto /out=salefec;run;
proc sort data=salefec;by descending count;
proc print data=salefec;run;
data _null_;set salefec;put efecto;run;
%mend;

%randomselect(data=datos.variables_transformadas_train,
listclass=REP_disc_number_track album_type explicit_track,
vardepen=popularity_track,
modelo=REP_disc_number_track album_type explicit_track EXP_key_min_track EXP_loudness_mean_track EXP_mode_max_track EXP_mode_track LOG_speechiness_track LOG_tempo_mean_track LOG_tempo_min_track LOG_total_followers_artist
LOG_valence_track PWR_danceability_track PWR_key_mean_track PWR_key_track PWR_loudness_max_track PWR_loudness_min_track PWR_loudness_track PWR_tempo_track 
PWR_time_signature_max_track PWR_time_signature_min_track SQRT_energy_track SQRT_instrumentalness_track SQRT_liveness_track SQRT_total_tracks_album SQR_mode_mean_track
SQR_mode_min_track acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_max_track key_mean_track key_min_track key_track
liveness_track loudness_max_track loudness_mean_track loudness_min_track loudness_track mode_max_track mode_mean_track mode_min_track mode_track speechiness_track
tempo_max_track tempo_mean_track tempo_min_track tempo_track time_signature_max_track time_signature_mean_track time_signature_min_track time_signature_track
total_followers_artist total_tracks_album track_number_track valence_track,
criterio=AIC,
sinicio=12345,
sfinal=12445,
fracciontrain=0.8, directorio=C:\Users\cris\Documents\TFM);
proc print data="hola";run;
proc copy inlib=work outlib=datos ;
select salefec;
run;
%randomselect(data=datos.variables_transformadas_train,
listclass=REP_disc_number_track album_type explicit_track,
vardepen=popularity_track,
modelo=REP_disc_number_track album_type explicit_track acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_max_track key_mean_track key_min_track key_track liveness_track 
loudness_max_track loudness_mean_track loudness_min_track loudness_track mode_max_track mode_mean_track mode_min_track mode_track speechiness_track tempo_max_track tempo_mean_track tempo_min_track tempo_track time_signature_max_track time_signature_mean_track time_signature_min_track time_signature_track total_followers_artist total_tracks_album track_number_track valence_track,
criterio=BIC,
sinicio=12345,
sfinal=12445,
fracciontrain=0.8, directorio=C:\Users\cris\Documents\TFM);
proc print data="hola";run;
proc copy inlib=work outlib=datos ;
select salefec;
run;
%randomselect(data=datos.variables_transformadas_train,
listclass=REP_disc_number_track album_type explicit_track,
vardepen=popularity_track,
modelo=REP_disc_number_track album_type explicit_track acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_max_track key_mean_track key_min_track key_track liveness_track 
loudness_max_track loudness_mean_track loudness_min_track loudness_track mode_max_track mode_mean_track mode_min_track mode_track speechiness_track tempo_max_track tempo_mean_track tempo_min_track tempo_track time_signature_max_track time_signature_mean_track time_signature_min_track time_signature_track total_followers_artist total_tracks_album track_number_track valence_track,
criterio=SBC,
sinicio=12345,
sfinal=12445,
fracciontrain=0.8, directorio=C:\Users\cris\Documents\TFM);
proc print data="hola";run;
proc copy inlib=work outlib=datos ;
select salefec;
run;



/*REGRESIONES CRUZADAS*/
%macro cruzada(archivo=,vardepen=,conti=,categor=,ngrupos=,sinicio=,sfinal=);
data final;run;
/* Bucle semillas */
%do semilla=&sinicio %to &sfinal;
	data dos;set &archivo;u=ranuni(&semilla);
	proc sort data=dos;by u;run;
	data dos;
	retain grupo 1;
	set dos nobs=nume;
	if _n_>grupo*nume/&ngrupos then grupo=grupo+1;
	run;
	data fantasma;run;
	%do exclu=1 %to &ngrupos;
		data tres;set dos;if grupo ne &exclu then vardep=&vardepen;
		proc glm data=tres noprint;/*<<<<<******SE PUEDE QUITAR EL NOPRINT */
		%if &categor ne %then %do;class &categor;model vardep=&conti &categor;%end;
		%else %do;model vardep=&conti;%end;
		output out=sal p=predi;run;
		data sal;set sal;resi2=(&vardepen-predi)**2;if grupo=&exclu then output;run;
		data fantasma;set fantasma sal;run;
	%end;
	proc means data=fantasma sum noprint;var resi2;
	output out=sumaresi sum=suma mean=media;
	run;
	data sumaresi;set sumaresi;semilla=&semilla;
	data final (keep=suma media semilla);set final sumaresi;if suma=. then delete;run;
%end;
proc print data=final;run;
%mend;

%cruzada(archivo=datos.variables_originales_train,vardepen=popularity_track,
conti= acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_min_track loudness_mean_track loudness_min_track loudness_track mode_mean_track mode_track speechiness_track time_signature_max_track time_signature_min_track time_signature_track total_followers_artist total_tracks_album track_number_track valence_track,
categor= album_type explicit_track,
ngrupos=4,sinicio=12345,sfinal=12445);
data final1;set final;modelo=1;

%cruzada(archivo=datos.variables_originales_train,vardepen=popularity_track,
conti= acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_min_track loudness_mean_track loudness_min_track loudness_track mode_mean_track mode_track speechiness_track time_signature_max_track time_signature_min_track time_signature_track total_followers_artist total_tracks_album track_number_track valence_track,
categor= album_type explicit_track,
ngrupos=4,sinicio=12345,sfinal=12445);
data final2;set final;modelo=2;

%cruzada(archivo=datos.variables_originales_train,vardepen=popularity_track,
conti= danceability_track duration_ms_track instrumentalness_track key_min_track loudness_min_track loudness_track time_signature_min_track time_signature_track total_followers_artist total_tracks_album valence_track,
categor= album_type explicit_track,
ngrupos=4,sinicio=12345,sfinal=12445);
data final3;set final;modelo=3;

%cruzada(archivo=datos.variables_originales_train,vardepen=popularity_track,
conti= acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_min_track loudness_min_track loudness_track mode_mean_track mode_track speechiness_track tempo_max_track tempo_mean_track tempo_min_track tempo_track time_signature_max_track time_signature_min_track time_signature_track total_followers_artist total_tracks_album track_number_track valence_track,
categor= album_type explicit_track,
ngrupos=4,sinicio=12345,sfinal=12445);
data final4;set final;modelo=4;

%cruzada(archivo=datos.variables_originales_train,vardepen=popularity_track,
conti= acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_min_track loudness_mean_track loudness_min_track loudness_track mode_mean_track mode_track speechiness_track tempo_max_track tempo_mean_track tempo_min_track tempo_track time_signature_max_track time_signature_min_track time_signature_track total_followers_artist total_tracks_album track_number_track valence_track,
categor= album_type explicit_track,
ngrupos=4,sinicio=12345,sfinal=12445);
data final5;set final;modelo=5;

%cruzada(archivo=datos.variables_originales_train,vardepen=popularity_track,
conti= acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_min_track loudness_min_track loudness_track mode_mean_track mode_track speechiness_track tempo_max_track tempo_mean_track tempo_min_track tempo_track time_signature_max_track time_signature_min_track time_signature_track total_followers_artist total_tracks_album track_number_track valence_track,
categor= album_type explicit_track,
ngrupos=4,sinicio=12345,sfinal=12445);
data final6;set final;modelo=6;

%cruzada(archivo=datos.variables_originales_train,vardepen=popularity_track,
conti= acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_min_track loudness_mean_track loudness_min_track loudness_track mode_mean_track mode_track speechiness_track tempo_max_track tempo_mean_track tempo_min_track tempo_track time_signature_max_track time_signature_min_track time_signature_track total_followers_artist total_tracks_album track_number_track valence_track,
categor= album_type explicit_track,
ngrupos=4,sinicio=12345,sfinal=12445);
data final7;set final;modelo=7;

%cruzada(archivo=datos.variables_originales_train,vardepen=popularity_track,
conti= acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_min_track loudness_min_track loudness_track time_signature_min_track time_signature_track total_followers_artist total_tracks_album valence_track,
categor= album_type explicit_track,
ngrupos=4,sinicio=12345,sfinal=12445);
data final8;set final;modelo=8;

%cruzada(archivo=datos.variables_originales_train,vardepen=popularity_track,
conti= acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_min_track loudness_mean_track loudness_min_track loudness_track mode_mean_track mode_track speechiness_track time_signature_max_track time_signature_min_track time_signature_track total_followers_artist total_tracks_album track_number_track valence_track,
categor= album_type explicit_track,
ngrupos=4,sinicio=12345,sfinal=12445);
data final9;set final;modelo=9;

%cruzada(archivo=datos.variables_originales_train,vardepen=popularity_track,
conti= acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_min_track loudness_mean_track loudness_min_track loudness_track mode_mean_track mode_track speechiness_track time_signature_max_track time_signature_min_track time_signature_track total_followers_artist total_tracks_album track_number_track valence_track,
categor= album_type explicit_track,
ngrupos=4,sinicio=12345,sfinal=12445);
data final10;set final;modelo=10;

%cruzada(archivo=datos.variables_originales_train,vardepen=popularity_track,
conti= danceability_track duration_ms_track instrumentalness_track key_min_track loudness_min_track loudness_track time_signature_min_track time_signature_track total_followers_artist total_tracks_album valence_track,
categor= album_type explicit_track,
ngrupos=4,sinicio=12345,sfinal=12445);
data final11;set final;modelo=11;
data union;set final1 final2 final3 final4 final5 final6 final7 final8 final9 final10 final11;
proc boxplot data=union;plot media*modelo;run;
/*cruzadas transformadas*/
%cruzada(archivo=datos.variables_transformadas_train,vardepen=popularity_track,
conti= EXP_key_min_track LOG_speechiness_track LOG_total_followers_artist LOG_valence_track PWR_loudness_track PWR_time_signature_max_track SQRT_instrumentalness_track SQRT_total_tracks_album acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_max_track key_min_track loudness_min_track mode_track speechiness_track time_signature_max_track time_signature_min_track time_signature_track total_followers_artist track_number_track valence_track,
categor= album_type explicit_track,
ngrupos=4,sinicio=12345,sfinal=12445);
data final12;set final;modelo=12;

%cruzada(archivo=datos.variables_transformadas_train,vardepen=popularity_track,
conti= EXP_key_min_track LOG_speechiness_track LOG_total_followers_artist LOG_valence_track PWR_loudness_track PWR_time_signature_max_track SQRT_instrumentalness_track SQRT_total_tracks_album acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_max_track key_min_track loudness_min_track mode_track speechiness_track time_signature_max_track time_signature_min_track time_signature_track total_followers_artist track_number_track valence_track,
categor= album_type explicit_track,
ngrupos=4,sinicio=12345,sfinal=12445);
data final13;set final;modelo=13;

%cruzada(archivo=datos.variables_transformadas_train,vardepen=popularity_track,
conti= LOG_total_followers_artist PWR_loudness_track PWR_time_signature_max_track SQRT_instrumentalness_track SQRT_total_tracks_album danceability_track duration_ms_track energy_track key_min_track loudness_min_track time_signature_min_track time_signature_track total_followers_artist valence_track,
categor= album_type explicit_track,
ngrupos=4,sinicio=12345,sfinal=12445);
data final14;set final;modelo=14;

%cruzada(archivo=datos.variables_transformadas_train,vardepen=popularity_track,
conti= EXP_key_min_track EXP_loudness_mean_track EXP_mode_track LOG_speechiness_track LOG_tempo_mean_track LOG_tempo_min_track LOG_total_followers_artist PWR_loudness_max_track PWR_loudness_min_track PWR_tempo_track PWR_time_signature_max_track SQRT_instrumentalness_track SQRT_total_tracks_album acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_max_track key_min_track loudness_max_track loudness_mean_track loudness_track speechiness_track tempo_max_track tempo_track time_signature_max_track time_signature_min_track time_signature_track total_followers_artist track_number_track valence_track,
categor= album_type explicit_track,
ngrupos=4,sinicio=12345,sfinal=12445);
data final15;set final;modelo=15;

%cruzada(archivo=datos.variables_transformadas_train,vardepen=popularity_track,
conti= EXP_key_min_track EXP_loudness_mean_track EXP_mode_track LOG_speechiness_track LOG_tempo_mean_track LOG_tempo_min_track LOG_total_followers_artist PWR_loudness_max_track PWR_loudness_min_track PWR_tempo_track PWR_time_signature_max_track SQRT_instrumentalness_track SQRT_total_tracks_album acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_max_track key_min_track loudness_max_track loudness_mean_track loudness_track speechiness_track tempo_max_track tempo_track time_signature_max_track time_signature_min_track time_signature_track total_followers_artist track_number_track valence_track,
categor= album_type explicit_track,
ngrupos=4,sinicio=12345,sfinal=12445);
data final16;set final;modelo=16;

%cruzada(archivo=datos.variables_transformadas_train,vardepen=popularity_track,
conti= EXP_key_min_track EXP_mode_track LOG_speechiness_track LOG_tempo_mean_track LOG_tempo_min_track LOG_total_followers_artist PWR_loudness_max_track PWR_tempo_track PWR_time_signature_max_track SQRT_energy_track SQRT_instrumentalness_track SQRT_total_tracks_album acousticness_track danceability_track duration_ms_track instrumentalness_track key_max_track key_min_track loudness_max_track loudness_min_track loudness_track speechiness_track tempo_max_track tempo_track time_signature_max_track time_signature_min_track time_signature_track total_followers_artist track_number_track valence_track,
categor= album_type explicit_track,
ngrupos=4,sinicio=12345,sfinal=12445);
data final17;set final;modelo=17;

%cruzada(archivo=datos.variables_transformadas_train,vardepen=popularity_track,
conti= LOG_total_followers_artist PWR_loudness_min_track PWR_loudness_track PWR_time_signature_max_track SQRT_total_tracks_album danceability_track duration_ms_track energy_track instrumentalness_track key_min_track time_signature_max_track time_signature_min_track total_followers_artist valence_track,
categor= album_type explicit_track,
ngrupos=4,sinicio=12345,sfinal=12445);
data final18;set final;modelo=18;

%cruzada(archivo=datos.variables_transformadas_train,vardepen=popularity_track,
conti= EXP_key_min_track LOG_speechiness_track LOG_total_followers_artist LOG_valence_track PWR_loudness_track PWR_time_signature_max_track SQRT_instrumentalness_track SQRT_total_tracks_album acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_max_track key_min_track loudness_min_track mode_track speechiness_track time_signature_max_track time_signature_min_track time_signature_track total_followers_artist track_number_track valence_track,
categor= album_type explicit_track,
ngrupos=4,sinicio=12345,sfinal=12445);
data final19;set final;modelo=19;

%cruzada(archivo=datos.variables_transformadas_train,vardepen=popularity_track,
conti= acousticness_track danceability_track duration_ms_track energy_track instrumentalness_track key_min_track loudness_mean_track loudness_min_track loudness_track mode_mean_track mode_track speechiness_track time_signature_max_track time_signature_min_track time_signature_track total_followers_artist total_tracks_album track_number_track valence_track,
categor= album_type explicit_track,
ngrupos=4,sinicio=12345,sfinal=12445);
data final20;set final;modelo=20;

%cruzada(archivo=datos.variables_transformadas_train,vardepen=popularity_track,
conti= danceability_track duration_ms_track instrumentalness_track key_min_track loudness_min_track loudness_track time_signature_min_track time_signature_track total_followers_artist total_tracks_album valence_track,
categor= album_type explicit_track,
ngrupos=4,sinicio=12345,sfinal=12445);
data final21;set final;modelo=21;

%cruzada(archivo=datos.variables_transformadas_train,vardepen=popularity_track,
conti= danceability_track duration_ms_track instrumentalness_track key_min_track loudness_min_track loudness_track mode_track time_signature_min_track time_signature_track total_followers_artist total_tracks_album valence_track,
categor= album_type explicit_track,
ngrupos=4,sinicio=12345,sfinal=12445);
data final22;set final;modelo=22;
data union;set final12 final13 final14 final15 final16 final17 final18 final19 final20 final21 final22;
proc boxplot data=union;plot media*modelo;run;

data union;set final1 final2 final3 final4 final5 final6 final7 final8 final9 final10 final11 final12 final13 final14 final15 final16 final17 final18 final19 final20 final21 final22;
proc boxplot data=union;plot media*modelo;run;

data union;set final12 final13 final14 final15 final16 final17 final18 final19;
proc boxplot data=union;plot media*modelo;run;

data union;set final1 final3 final4 final5 final8 final9 final12 final14 final15 final17 final18 final22;
proc boxplot data=union;plot media*modelo;run;

data final100;set final1;modelo=1;
data final101;set final3;modelo=2;
data final102;set final4;modelo=3;
data final103;set final5;modelo=4;
data final104;set final8;modelo=5;
data final105;set final9;modelo=6;
data final106;set final12;modelo=7;
data final107;set final14;modelo=8;
data final108;set final15;modelo=9;
data final109;set final17;modelo=10;
data final110;set final18;modelo=11;
data final111;set final22;modelo=12;

title 'Regresión lineal';
data union;set final100 final101 final102 final103 final104 final105 final106 final107 final108 final109 final110 final111;
proc boxplot data=union;plot media*modelo;run;
title 'Regresión lineal';
data union;set final106 final107 final108 final109 final110;
proc boxplot data=union;plot media*modelo;run;

