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
#Aqui habria que hacer el bucle de los paises   
contador=0
lista_pais=pd.DataFrame()
for c in country_list:
    print(c)
    results2 = spotify.featured_playlists(country=c)
    #Creamos un dataframe con las playlists
    hola=results2['playlists']
    df_playlists=json_to_dict_to_df(hola)
    df_playlists = df_playlists.rename(columns=lambda x: str(x)+'_playlist')
    listas=df_playlists['items_playlist']
    def_playlists= pd.DataFrame()
    for lista in listas:       
        aux_playlists= json_to_dict_to_df(lista)
        print(aux_playlists)
        aux_playlists=aux_playlists.iloc[0,0]
        def_playlists = def_playlists.append(aux_playlists, ignore_index=True)
        print(def_playlists)
    
    def_playlists = def_playlists.rename(columns=lambda x: str(x)+'_playlist_')    
    df_playlists = pd.concat([df_playlists,def_playlists], axis=1)

    ids=df_playlists['id_playlist_']
    tracks_playlists= pd.DataFrame()
    for id_lista in ids: #vamos a coger el id de las listas para buscar sus canciones
        print(id_lista)
        tracks_of_playlist = spotify.playlist_tracks(playlist_id=id_lista)
        if (tracks_of_playlist==None): continue
        aux_playlists=json_to_dict_to_df(tracks_of_playlist)
        items=aux_playlists.iloc[0,1]
        print("IMPRIMIR EL ITEM")
        jtopy3=json.dumps(items) #json.dumps take a dictionary as input and returns a string as output.
        dict_json3=json.loads(jtopy3)
        items_df= pd.DataFrame(dict_json3)
        listatrack= items_df.iloc[:,4]
        print("IMPRIMO EL TRACK")
        print(len(listatrack))
        features=total_features_track(items_df,"track of playlist")
        total_df= pd.concat([aux_playlists,features], sort= False, axis=1)
        lista_name=list(aux_playlists)
        col=0
        for i in lista_name:
            total_df[i]=pd.Series(total_df.iloc[0,col])
            col=col+1
        tracks_playlists = tracks_playlists.append(total_df, ignore_index=True, sort=False)
                
    tracks_playlists.columns    
    tracks_playlists['country']= c#al final
    lista_pais = lista_pais.append(tracks_playlists, ignore_index=True)
    contador=contador+1

lista_pais.columns
file=lista_pais.to_csv (r'C:\home\playlist_paises_2.csv', index=False,header=1)