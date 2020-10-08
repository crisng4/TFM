import sys
import spotipy
from spotipy.oauth2 import SpotifyClientCredentials
import json
import ast
import pandas as pd 
import statistics
import numpy as np
cid ="e5edecb240e447a79f9fc1f03ca04af7"
secret = "f73e0d0c935d4febb70d51456d8f393a"
spotify = spotipy.Spotify(client_credentials_manager=SpotifyClientCredentials(client_id=cid, client_secret=secret, requests_timeout = 100))
print(spotify.requests_timeout)
spotify.requests_timeout=100
print(spotify)
country_list=[ "AD", "AR", "AT", "AU", "BE", "BG", "BO", 
              "BR", "CH", "CL", "CO", "CR", "CY", "CZ", 
              "DK", "DO", "EC", "EE", "ES", "FI", "FR", "GB", "GR", "GT", "HK", 
              "HN", "HU", "IE", "IS", "IT", "LI", "LT", "LU", "LV", "MC", "MT", "MY", 
              "NI", "NL", "NO", "NZ", "PA", "PE", "PH", "PL", "PT", "PY", "RO", "SE", "SG", 
              "SI", "SK", "SV", "TR", "TW", "UY"]

file_country = pd.read_csv("C:\home\playlist_paises_2.csv")#aqui tienes que poner tu ruta
file_country.columns
id_track=file_country['id_track']
id_track_sin_drop= id_track.drop_duplicates()
names_artista=file_country['name_artist_track']
ids_artista=file_country['id_artist_track']
names_artista_sin_drop=names_artista.drop_duplicates()
ids_artista_sin_drop=ids_artista.drop_duplicates()
fil3e=ids_artista_sin_drop.to_csv (r'ids_artistas.csv', index=False,header=1)

ids2 = pd.read_csv("ids_artistas.csv")
ids_list=ids2.iloc[:,0]
yds_lis=ids_list.drop_duplicates()
ids_list2=pd.Series.tolist(ids_list)
cont=0
artistas_songs3=pd.DataFrame()
for i in ids_list2:
    print(cont)
    if (i==None): continue
    try:
        a=spotify.artist_top_tracks(i)
    except:
        print("Artista no encontrado")
        continue
    
    b=json_to_dict_to_df(a)
    artist_t=b.iloc[0,0]
    if (artist_t==[]): continue
    artist_a=pd.DataFrame(artist_t)
    #f=total_features_track2(artist_a)
    f=total_features_track_from_artist(artist_a,"hola")
    #print(id_album)
    artistas_songs3 = artistas_songs3.append(f, ignore_index=True, sort=False)
    cont=cont+1


file_total=total.to_csv (r'total_artistas.csv', index=False,header=1)
t=pd.read_csv('total_artistas.csv')
t['Unnamed: 0']
list_columns=t.columns
print(type(list_columns))
print(list_columns.tolist())
d=list_columns.tolist()
c=d.to_csv (r'columns_total_artistas.csv', header=1)
paises=total.copy()
paises2.drop(['href', 'items', 'limit', 'next', 'offset', 'previous', 'total'], axis='columns', inplace=True)
paises.columns
p=paises.drop_duplicates(subset='id_track',keep='first')
ids=p['id_track']
ids2=pd.DataFrame()
ids2=ids2.append(ids, ignore_index=True, sort=False)
ids2=ids2.append(id_track, ignore_index=True, sort=False)
total_ids_df= pd.concat([ids,id_track], sort= False, axis=0)
p1=ids2.drop_duplicates(keep='first')

id_track=file_country['id_track']
ids2 = pd.read_csv("ids_artistas.csv")

t=pd.read_csv('total_artistas.csv')
dfeliminado=t.copy()
dfeliminado.drop([ 'Unnamed: 0', 'album_track', 'artists_track', 'available_markets_track', 'external_ids_track',
 'external_urls_track', 'href_track',  'is_local_track', 'name_track', 'preview_url_track', 'uri_track',
 'track_track',  'bars_track', 'beats_track', 'sections_track', 'segments_track', 'tatums_track', 'type_track.1',
 'id_track.1', 'uri_track.1', 'track_href_track', 'analysis_url_track', 'duration_ms_track.1', 'artists_album_track',
 'external_urls_album_track',  'href_album_track', 'id_album_track', 'images_album_track', 'name_album_track',  'release_date_album_track',
 'release_date_precision_album_track',  'uri_album_track', 'album_type_album_track.1',  'artists_album_track.1',  'available_markets_album_track',
 'copyrights_album_track', 'external_ids_album_track', 'external_urls_album_track.1', 'genres_album_track', 'href_album_track.1', 'id_album_track.1',
 'images_album_track.1', 'name_album_track.1', 'popularity_album_track', 'release_date_album_track.1', 'release_date_precision_album_track.1', 'total_tracks_album_track.1',
 'tracks_album_track', 'type_album_track.1', 'uri_album_track.1', 'external_urls_artist_track', 'href_artist_track', 'id_artist_track', 'name_artist_track',
 'type_artist_track', 'uri_artist_track', 'external_urls_artist_track.1', 'followers_artist_track', 'href_artist_track.1', 'id_artist_track.1', 'images_artist_track',
 'name_artist_track.1', 'popularity_artist_track', 'type_artist_track.1', 'uri_artist_track.1',
 'href_followers_artist_track'], axis='columns', inplace=True)
    
paises_eliminado=file_country.copy()
paises_eliminado.drop([ 'href', 'items', 'limit', 'next', 'offset', 'previous', 'total', 'album_track', 'artists_track', 'available_markets_track', 'external_ids_track',
 'external_urls_track', 'href_track', 'is_local_track', 'name_track', 'preview_url_track', 'uri_track',
 'track_track',  'bars_track', 'beats_track', 'sections_track', 'segments_track', 'tatums_track', 'type_track.1',
 'id_track.1', 'uri_track.1', 'track_href_track', 'analysis_url_track', 'duration_ms_track.1', 'artists_album_track',
 'external_urls_album_track',  'href_album_track', 'id_album_track', 'images_album_track', 'name_album_track',  'release_date_album_track',
 'release_date_precision_album_track',  'uri_album_track', 'album_type_album_track.1',  'artists_album_track.1',  'available_markets_album_track',
 'copyrights_album_track', 'external_ids_album_track', 'external_urls_album_track.1', 'genres_album_track', 'href_album_track.1', 'id_album_track.1',
 'images_album_track.1', 'name_album_track.1', 'popularity_album_track', 'release_date_album_track.1', 'release_date_precision_album_track.1', 'total_tracks_album_track.1',
 'tracks_album_track', 'type_album_track.1', 'uri_album_track.1', 'external_urls_artist_track', 'href_artist_track', 'id_artist_track', 'name_artist_track',
 'type_artist_track', 'uri_artist_track', 'external_urls_artist_track.1', 'followers_artist_track', 'href_artist_track.1', 'id_artist_track.1', 'images_artist_track',
 'name_artist_track.1', 'popularity_artist_track', 'type_artist_track.1', 'uri_artist_track.1',
 'href_followers_artist_track','country', 'available_markets_album_track.1'], axis='columns', inplace=True)
col=paises_eliminado.columns
type(col)
new_order = ['id_track','disc_number_track', 'duration_ms_track', 'explicit_track',
       'popularity_track', 'track_number_track', 'type_track', 'meta_track',
       'key_min_track', 'key_max_track', 'key_mean_track',
       'loudness_min_track', 'loudness_max_track', 'loudness_mean_track',
       'mode_min_track', 'mode_max_track', 'mode_mean_track',
       'tempo_min_track', 'tempo_max_track', 'tempo_mean_track',
       'time_signature_min_track', 'time_signature_max_track',
       'time_signature_mean_track', 'acousticness_track', 'danceability_track',
       'energy_track', 'instrumentalness_track', 'key_track', 'liveness_track',
       'loudness_track', 'mode_track', 'speechiness_track', 'tempo_track',
       'time_signature_track', 'valence_track', 'album_type_album_track',
       'total_tracks_album_track', 'type_album_track', 'label_album_track',
       'genres_artist_track', 'total_followers_artist_track']
df2=dfeliminado[['id_track','disc_number_track', 'duration_ms_track', 'explicit_track',
       'popularity_track', 'track_number_track', 'type_track', 'meta_track',
       'key_min_track', 'key_max_track', 'key_mean_track',
       'loudness_min_track', 'loudness_max_track', 'loudness_mean_track',
       'mode_min_track', 'mode_max_track', 'mode_mean_track',
       'tempo_min_track', 'tempo_max_track', 'tempo_mean_track',
       'time_signature_min_track', 'time_signature_max_track',
       'time_signature_mean_track', 'acousticness_track', 'danceability_track',
       'energy_track', 'instrumentalness_track', 'key_track', 'liveness_track',
       'loudness_track', 'mode_track', 'speechiness_track', 'tempo_track',
       'time_signature_track', 'valence_track', 'album_type_album_track',
       'total_tracks_album_track', 'type_album_track', 'label_album_track',
       'genres_artist_track', 'total_followers_artist_track']]
df3=paises_eliminado[['id_track','disc_number_track', 'duration_ms_track', 'explicit_track',
       'popularity_track', 'track_number_track', 'type_track', 'meta_track',
       'key_min_track', 'key_max_track', 'key_mean_track',
       'loudness_min_track', 'loudness_max_track', 'loudness_mean_track',
       'mode_min_track', 'mode_max_track', 'mode_mean_track',
       'tempo_min_track', 'tempo_max_track', 'tempo_mean_track',
       'time_signature_min_track', 'time_signature_max_track',
       'time_signature_mean_track', 'acousticness_track', 'danceability_track',
       'energy_track', 'instrumentalness_track', 'key_track', 'liveness_track',
       'loudness_track', 'mode_track', 'speechiness_track', 'tempo_track',
       'time_signature_track', 'valence_track', 'album_type_album_track',
       'total_tracks_album_track', 'type_album_track', 'label_album_track',
       'genres_artist_track', 'total_followers_artist_track']]
paises_eliminado[paises_eliminado.columns[new_order]]
if(list(df2.columns)==list(df3.columns)):
    print("son iguales")
dfeliminado.columns

df4=pd.DataFrame()
df4=df4.append(df3, ignore_index=True, sort=False)
df4=df4.append(df2, ignore_index=True, sort=False)
df5=df4.drop_duplicates(subset='id_track',keep='first')
file_total=df5.to_csv (r'final.csv', index=False,header=1)
final=pd.read_csv('final.csv')
ids_list=final['id_track']
yds_lis=ids_list.drop_duplicates()
ids_list2=pd.Series.tolist(ids_list)
#yds_lis=ids_list2.drop_duplicates()
#ids_list = ids2.values.tolist()
#ids2=pd.Dataframe.tolist(ids_artista_sin_drop)
cont=0
ids3=ids_list2[13000:14094]
#len(ids3)
#print(len(ids_list2))
artistas_songs3=pd.DataFrame()
for i in ids3:
#for i in ids3:

    #print(cont)
    #if (cont==2): break
    if (i==None): continue
    #try:
    a=get_audio_analysis_track(i)
    a['id_track']=i
    #except:
    #    print("Error en la cancion")
    #    cont=cont+1
     #   continue
    
    #b=json_to_dict_to_df(a)
    #artist_t=b.iloc[0,0]
    #if (artist_t==[]): continue
    #artist_a=pd.DataFrame(artist_t)
    #f=total_features_track2(artist_a)
    #f=total_features_track_from_artist(artist_a,"hola")
    #print(id_album)
    artistas_songs3 = artistas_songs3.append(a, ignore_index=True, sort=False)
    div=cont%1000
    if(div==0):
        print(cont)
    cont=cont+1
    
featl=artistas_songs3.to_csv (r'total_loudness14.csv', index=False,header=1)    

l1 = pd.read_csv('total_loudness1.csv')
l2 = pd.read_csv('total_loudness2.csv')
l3 = pd.read_csv('total_loudness3.csv')
l4 = pd.read_csv('total_loudness4.csv')
l5 = pd.read_csv('total_loudness5.csv')
l6 = pd.read_csv('total_loudness6.csv')
l7 = pd.read_csv('total_loudness7.csv')
l8 = pd.read_csv('total_loudness8.csv')
l9 = pd.read_csv('total_loudness9.csv')
l10 = pd.read_csv('total_loudness10.csv')
l11 = pd.read_csv('total_loudness11.csv')
l12 = pd.read_csv('total_loudness12.csv')
l13 = pd.read_csv('total_loudness13.csv')
l14 = pd.read_csv('total_loudness14.csv')

total_final=pd.DataFrame()
total_final  = total_final.append(l1, ignore_index=True, sort=False)
total_final  = total_final.append(l2, ignore_index=True, sort=False)
total_final  = total_final.append(l3, ignore_index=True, sort=False)
total_final  = total_final.append(l4, ignore_index=True, sort=False)
total_final  = total_final.append(l5, ignore_index=True, sort=False)
total_final  = total_final.append(l6, ignore_index=True, sort=False)
total_final  = total_final.append(l7, ignore_index=True, sort=False)
total_final  = total_final.append(l8, ignore_index=True, sort=False)
total_final  = total_final.append(l9, ignore_index=True, sort=False)   
total_final  = total_final.append(l10, ignore_index=True, sort=False)
total_final  = total_final.append(l11, ignore_index=True, sort=False)
total_final  = total_final.append(l12, ignore_index=True, sort=False)
total_final  = total_final.append(l13, ignore_index=True, sort=False)
total_final  = total_final.append(l14, ignore_index=True, sort=False)   

copy_total= total_final.copy()

featl1=total_final.to_csv (r'mitadfinal.csv', index=False,header=1)   
total_final.columns
total2=total_final.copy()
total_final.drop([ 'bars', 'beats', 'meta', 'sections', 'segments', 'tatums', 'track'], axis='columns', inplace=True)
final2=final.copy()
final.columns
final2.drop([ 'key_min_track', 'key_max_track', 'key_mean_track',
       'loudness_min_track', 'loudness_max_track', 'loudness_mean_track',
       'mode_min_track', 'mode_max_track', 'mode_mean_track',
       'tempo_min_track', 'tempo_max_track', 'tempo_mean_track',
       'time_signature_min_track', 'time_signature_max_track',
       'time_signature_mean_track'], axis='columns', inplace=True)

final_def= pd.concat([final2,total_final], sort= False, axis=1)
final_def.columns
final3=final_def.iloc[:,0:41]
final3.columns
f=final3.drop_duplicates(subset='id_track',keep='first')
fichero_final=final3.to_csv (r'final_definitivo.csv', index=False,header=1)  
fichero = pd.read_csv('final_definitivo.csv')
fichero1=fichero.copy()
print(len(fichero.columns))
print(fichero['type_album_track'])

f1=fichero['type_album_track']
f=f1.tolist()
f2=fichero['type_track']
f_=f2.tolist()
f3=fichero['type_track']
_f_=f3.tolist()

f4=fichero['meta_track']
f=f4.tolist()


fichero1.drop(['meta_track','type_album_track','type_track' ], axis='columns', inplace=True)
print(len(fichero1.columns))
print(fichero1.columns)
fichero1.columns=['id_track', 'disc_number_track', 'duration_ms_track', 'explicit_track',
       'popularity_track', 'track_number_track', 'acousticness_track',
       'danceability_track', 'energy_track', 'instrumentalness_track',
       'key_track', 'liveness_track', 'loudness_track', 'mode_track',
       'speechiness_track', 'tempo_track', 'time_signature_track',
       'valence_track', 'album_type', 'total_tracks_album',
       'label_album', 'genres_artist',
       'total_followers_artist', 'key_min_track', 'key_max_track', 'key_mean_track',
       'loudness_min_track', 'loudness_max_track', 'loudness_mean_track', 'mode_min_track', 'mode_max_track',
       'mode_mean_track', 'tempo_min_track', 'tempo_max_track', 'tempo_mean_track',
       'time_signature_min_track', 'time_signature_max_track', 'time_signature_mean_track']
fichero_final_=fichero1.to_csv (r'final_definitivo_.csv', index=False,header=1) 