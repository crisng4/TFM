library(sas7bdat)
library(dummies)
library(MASS)
library(reshape)
library(caret)
library(dplyr)
library(pROC)
library(readr)
library(haven)
library(stringr)

file<-read.sas7bdat("c:/Users/cris/Documents/TFM/variables_transformadas_train.sas7bdat")

file$album_type<-as.factor(file$album_type)
file$explicit_track<-as.factor(file$explicit_track)



vardep<-"popularity_track"
conti<- c("EXP_key_min_track", "LOG_speechiness_track", "LOG_total_followers_artist", "LOG_valence_track",
          "PWR_loudness_track", "PWR_time_signature_max_track", "SQRT_instrumentalness_track",
          "SQRT_total_tracks_album","acousticness_track", "danceability_track", "duration_ms_track",
          "energy_track","instrumentalness_track","key_max_track", "key_min_track", "loudness_min_track",
          "mode_track", "speechiness_track","time_signature_max_track", "time_signature_min_track",
          "time_signature_track", "total_followers_artist", "track_number_track", "valence_track")
categor<- c("album_type", "explicit_track")

grupos<-4
sinicio<-12345
repe<-5