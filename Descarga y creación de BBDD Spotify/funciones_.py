def total_features_track(items,str_track):
    count=1
    print(items.shape)
    lista_track=items.iloc[:,4] #cogemos el objeto track donde vienen los datos de la cancion
    print(len(lista_track))
    features= pd.DataFrame()
    for i in lista_track:
        if (i==None): continue
        aux=json_to_dict_to_df(i)
        id_track=aux.iloc[0,10]
        if (id_track==None): continue
        try:
            track=spotify.track(id_track)
            track_df= json_to_dict_to_df(track)
        except:
            print("Cancion no encontrada")
            continue
        try:
            track1b_df=get_audio_analysis_track(id_track)
        except:
            print("Cancion no encontrada")
            continue
        try:
            track2_df=get_audio_features_track(id_track)
        except:
            print("Cancion 2 no encontrada")
            continue
        album=aux.iloc[0,0]
        try:
            album2_df = get_info_album(album,str_track)
        except:
            print("Album no encontrado")
            continue
        artist=aux.iloc[0,1]
        try:
            artist3_df = get_info_artist(artist)
        except:
            print("Artista no encontrado")
            continue
        
        tracks = pd.concat([track_df,track1b_df,track2_df], axis=1, sort=False)
        print(type(track_df))
        print(type(track1b_df))
        print(type(track2_df))
        print(type(tracks))
        print(type(album2_df))
        print(type(artist3_df))
        tracks = pd.concat([tracks,album2_df,artist3_df], axis=1, sort=False)
        tracks = tracks.rename(columns=lambda x: str(x)+'_track')
        features = features.append(tracks, ignore_index=True, sort=False)
        print(count)
        count=count+1
        print(len(lista_track))
    return features

def get_audio_analysis_track(id_track):
    track1=spotify.audio_analysis(id_track)
    track1_df= json_to_dict_to_df(track1)
    track1a_df=some_caracter(track1_df)
    track1b_df=pd.concat([track1_df,track1a_df], axis=1, sort=False)
    return track1b_df
    
def get_audio_features_track(id_track):
    track2=spotify.audio_features(id_track)
    track2_dfa= json_to_dict_to_df(track2)
    muestra=track2_dfa.iloc[0,0]
    track2_df=json_to_dict_to_df(muestra)
    return track2_df
 
def get_info_artist(artist):
    artist_df= json_to_dict_to_df(artist)
    artist2=artist_df.iloc[0,0]
    artist2_df= json_to_dict_to_df(artist2)
    id_artist=artist2_df.iloc[0,2]
    info_artist=spotify.artist(id_artist)
    info_artist_df= json_to_dict_to_df(info_artist)
    followers=info_artist_df.iloc[0,1]
    followers_df=json_to_dict_to_df(followers)
    followers_df = followers_df.rename(columns=lambda x: str(x)+'_followers')
    artist3_df = pd.concat([artist2_df,info_artist_df,followers_df], axis=1, sort=False)
    artist3_df = artist3_df.rename(columns=lambda x: str(x)+str('_artist'))
    return artist3_df
    
def get_info_album(album,type_object_music):
    album_df= json_to_dict_to_df(album)
    if(type_object_music=="track of playlist"):
        id_album=album_df.iloc[0,5]
    else:
        id_album=album_df.iloc[0,4]
    info_album=spotify.album(id_album)
    info_album_df= json_to_dict_to_df(info_album)
    album2_df = pd.concat([album_df,info_album_df], axis=1, sort=False)
    album2_df = album2_df.rename(columns=lambda x: x+'_album')
    return album2_df



def json_to_dict_to_df(dataframe):
    jtopy=json.dumps(dataframe) #json.dumps take a dictionary as input and returns a string as output.
    dict_json=json.loads(jtopy)
    df=pd.DataFrame([dict_json])
    return df

def some_caracter(dataframe):
    sections=dataframe.iloc[0,3]
    #print(len(sections))
    key_l=[]
    loudness_l=[]
    mode_l=[]
    tempo_l=[]
    time_signature_l=[]
    for i in sections:
        df=json_to_dict_to_df(i)
        key=df.iloc[0,2]
        key_l.append(key)
        loudness=df.iloc[0,4]
        loudness_l.append(loudness)
        #print(loudness_l)
        mode=df.iloc[0,5]
        mode_l.append(mode)
        tempo=df.iloc[0,8]
        tempo_l.append(tempo)
        time_signature=df.iloc[0,10]
        time_signature_l.append(time_signature)
    k_l=ratio(key_l)
    #print("imprimimos loudness")
    #print(loudness_l)
    l_l=ratio(loudness_l)
    m_l=ratio(mode_l)
    t_l=ratio(tempo_l)
    ts_l=ratio(time_signature_l)
    lista_final=k_l+l_l+m_l+t_l+ts_l
    
    df_final = pd.DataFrame(np.array(lista_final).reshape(1,15), 
                            columns = ('key_min','key_max','key_mean','loudness_min','loudness_max','loudness_mean',
                                       'mode_min','mode_max','mode_mean','tempo_min','tempo_max','tempo_mean',
                                       'time_signature_min','time_signature_max','time_signature_mean'))
    #print(df_final)
    return df_final
    
def ratio(lista):
    #print(lista)
    minimo=min(lista)
    maximo=max(lista)
    media= statistics.mean(lista)
    l=[minimo,maximo,media]
    #print(l)
    return l 

def total_features_track_from_artist(items,str_track):
    count=0
    lista_track=items.iloc[:,8]
    aux=items
    album_s=items.iloc[:,0]
    #artist_s=items.iloc[:,1]
    features= pd.DataFrame()
    for i in lista_track:
        if (i==None): continue
        id_track=i
        try:
            track=spotify.track(id_track)
            track_df= json_to_dict_to_df(track)
        except:
            print("ID no encontrado")
            continue
        try:
            track1b_df=get_audio_analysis_track(id_track)
        except:
            print("Cancion no encontrada")
            continue
        try:
            track2_df=get_audio_features_track(id_track)
        except:
            print("Cancion 2 no encontrada")
            continue
        album=items.iloc[0,0]
        try:
            #album_df= json_to_dict_to_df(album)
            #id_album=album_df.iloc[0,4]
            album2_df = get_info_album(album,str_track)
            #print(id_album)
        except:
            print("Album no encontrado")
            continue
        #album=album_s[count]
        #print("hola2")
        #album_df= json_to_dict_to_df(album)
        #id_album=album_df.iloc[0,4]
        #try:
        #    info_album=spotify.album(id_album)
        #    info_album_df= json_to_dict_to_df(info_album)
        #    album2_df = pd.concat([album_df,info_album_df], axis=1, sort=False)
        #    album2_df = album2_df.rename(columns=lambda x: x+'_album')
        #except:
        #    print("Album no encontrado")
        #    count=count+1
        #    continue
        
        artist=items.iloc[0,1]
        try:
            artist3_df = get_info_artist(artist)
        except:
            print("Artista no encontrado")
            continue
        
        tracks = pd.concat([track_df,track1b_df,track2_df], axis=1, sort=False)
        tracks = pd.concat([tracks,album2_df,artist3_df], axis=1, sort=False)
        tracks = tracks.rename(columns=lambda x: str(x)+'_track')
        features = features.append(tracks, ignore_index=True, sort=False)
        #print(count)
        count=count+1
        #print(len(lista_track))
    return features

