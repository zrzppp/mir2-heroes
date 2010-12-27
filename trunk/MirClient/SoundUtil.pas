unit SoundUtil;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  DXDraws, DirectX, DXClass, ExtCtrls, HUtil32, Grobal2, DXSounds;
var
  CurVolume: Integer;

procedure LoadSoundList(flname: string);
procedure LoadBGMusicList(flname: string);
procedure PlaySound(idx: Integer); overload;
procedure PlaySound(const FileName: string); overload;
function PlayBGM(wavname: string): TDirectSoundBuffer;
procedure PlayMp3(wavname: string; boFlag: Boolean);
procedure SilenceSound;
procedure ItemClickSound(std: TStdItem);
procedure ItemUseSound(StdMode: Integer);
procedure PlayMapMusic(boFlag: Boolean);

type
  SoundInfo = record
    idx: Integer;
    Name: string;
  end;

const
  bmg_intro = 'wav\log-in-long2.wav';
  bmg_select = 'wav\sellect-loop2.wav';
  bmg_field = 'wav\Field2.wav';
  bmg_gameover = 'wav\game over2.wav';
  SelectBoxFlash = 'wav\SelectBoxFlash.wav';
  Flashbox = 'wav\Flashbox.wav';
  hero_shield = 'wav\hero-shield.wav';


  s_walk_ground_l = 1;
  s_walk_ground_r = 2;
  s_run_ground_l = 3;
  s_run_ground_r = 4;
  s_walk_stone_l = 5;
  s_walk_stone_r = 6;
  s_run_stone_l = 7;
  s_run_stone_r = 8;
  s_walk_lawn_l = 9;
  s_walk_lawn_r = 10;
  s_run_lawn_l = 11;
  s_run_lawn_r = 12;
  s_walk_rough_l = 13;
  s_walk_rough_r = 14;
  s_run_rough_l = 15;
  s_run_rough_r = 16;
  s_walk_wood_l = 17;
  s_walk_wood_r = 18;
  s_run_wood_l = 19;
  s_run_wood_r = 20;
  s_walk_cave_l = 21;
  s_walk_cave_r = 22;
  s_run_cave_l = 23;
  s_run_cave_r = 24;
  s_walk_room_l = 25;
  s_walk_room_r = 26;
  s_run_room_l = 27;
  s_run_room_r = 28;
  s_walk_water_l = 29;
  s_walk_water_r = 30;
  s_run_water_l = 31;
  s_run_water_r = 32;


  s_hit_short = 50;
  s_hit_wooden = 51;
  s_hit_sword = 52;
  s_hit_do = 53;
  s_hit_axe = 54;
  s_hit_club = 55;
  s_hit_long = 56;
  s_hit_fist = 57;




  s_struck_short = 60;
  s_struck_wooden = 61;
  s_struck_sword = 62;
  s_struck_do = 63;
  s_struck_axe = 64;
  s_struck_club = 65;

  s_struck_body_sword = 70;
  s_struck_body_axe = 71;
  s_struck_body_longstick = 72;
  s_struck_body_fist = 73;

  s_struck_armor_sword = 80;
  s_struck_armor_axe = 81;
  s_struck_armor_longstick = 82;
  s_struck_armor_fist = 83;

  //s_powerup_man         = 80;
  //s_powerup_woman       = 81;
  //s_die_man             = 82;
  //s_die_woman           = 83;
  //s_struck_man          = 84;
  //s_struck_woman        = 85;
  //s_firehit             = 86;

  //s_struck_magic        = 90;
  s_strike_stone = 91;
  s_drop_stonepiece = 92;

  s_rock_door_open = 100;
  s_intro_theme = 102;
  s_meltstone = 101;
  s_main_theme = 102;
  s_norm_button_click = 103;
  s_rock_button_click = 104;
  s_glass_button_click = 105;
  s_money = 106;
  s_eat_drug = 107;
  s_click_drug = 108;
  s_spacemove_out = 109;
  s_spacemove_in = 110;

  s_click_weapon = 111;
  s_click_armor = 112;
  s_click_ring = 113;
  s_click_armring = 114;
  s_click_necklace = 115;
  s_click_helmet = 116;
  s_click_grobes = 117;
  s_itmclick = 118;

  s_yedo_man = 130;
  s_yedo_woman = 131;
  s_longhit = 132;
  s_widehit = 133;
  s_rush_l = 134;
  s_rush_r = 135;
  s_firehit_ready = 136;
  s_firehit = 137;

  s_man_struck = 138;
  s_wom_struck = 139;
  s_man_die = 144;
  s_wom_die = 145;

var
  s_FireFlower_1: Integer = -1;
  s_FireFlower_2: Integer = -1;
  s_FireFlower_3: Integer = -1;
  s_HeroLogIn: Integer = -1;
  s_HeroLogOut: Integer = -1;
  s_hero_shield: Integer = -1;

  s_SelectBoxFlash: Integer = -1;
  s_Flashbox: Integer = -1;

  s_Openbox: Integer = -1;
  s_powerup: Integer = -1;


  s_hit_ZRJF_M: Integer = -1;
  s_hit_ZRJF_w: Integer = -1;

 { s_cboZs_SJS_M: Integer = -1;
  s_cboZs_SJS_w: Integer = -1;
  s_cboZs_ZXC: Integer = -1;
  s_cboZs_DYZ_M: Integer = -1;
  s_cboZs_DYZ_w: Integer = -1;
  s_cboZs_HSQJ: Integer = -1;  }

  s_cboZs1_start_m: Integer = -1;
  s_cboZs1_start_w: Integer = -1;
  s_cboZs2_start: Integer = -1;
  s_cboZs3_start_m: Integer = -1;
  s_cboZs3_start_w: Integer = -1;
  s_cboZs4_start: Integer = -1;


  s_cboFs1_start: Integer = -1;
  s_cboFs1_target: Integer = -1;

  s_cboFs2_start: Integer = -1;
  s_cboFs2_target: Integer = -1;

  s_cboFs3_start: Integer = -1;
  s_cboFs3_target: Integer = -1;

  s_cboFs4_start: Integer = -1;
  s_cboFs4_target: Integer = -1;


  s_cboDs1_start: Integer = -1;
  s_cboDs1_target: Integer = -1;

  s_cboDs2_start: Integer = -1;
  s_cboDs2_target: Integer = -1;

  s_cboDs3_start: Integer = -1;
  s_cboDs3_target: Integer = -1;

  s_cboDs4_start: Integer = -1;
  s_cboDs4_target: Integer = -1;
implementation

uses
  ClMain, MShare, PlugIn;

procedure LoadSoundList(flname: string);
var
  I, k, idx, n: Integer;
  strlist: TStringList;
  Str, data: string;
begin
  if FileExists(flname) then begin
    strlist := TStringList.Create;
    strlist.LoadFromFile(flname);
    idx := 0;
    for I := 0 to strlist.Count - 1 do begin
      Str := strlist[I];
      if Str <> '' then begin
        if Str[1] = ';' then Continue;
        Str := Trim(GetValidStr3(Str, data, [':', ' ', #9]));
        n := Str_ToInt(data, 0);
        if n > idx then begin
          for k := 0 to n - g_SoundList.Count - 1 do
            g_SoundList.Add('');
          g_SoundList.Add(Str);
          idx := n;
        end;
      end;
    end;
    strlist.Free;
    g_nNewsound := g_SoundList.Count;

    g_SoundList.Add('wav\newysound1.wav'); //+0
    g_SoundList.Add('wav\newysound2.wav'); //+1
    g_SoundList.Add('wav\newysound-mix.wav'); //+2
    g_SoundList.Add('wav\HeroLogin.wav'); //+3
    g_SoundList.Add('wav\HeroLogout.wav'); //+4
    g_SoundList.Add('wav\S1-1.wav'); //+5
    g_SoundList.Add('wav\S1-2.wav'); //+6
    g_SoundList.Add('wav\S1-3.wav'); //+7
    g_SoundList.Add('wav\Openbox.wav'); //+8
    g_SoundList.Add(SelectBoxFlash); //+9
    g_SoundList.Add(Flashbox); //+10
    g_SoundList.Add(hero_shield); //+11
    g_SoundList.Add('wav\powerup.wav'); //+12




    g_SoundList.Add('wav\M56-0.wav'); //+13
    g_SoundList.Add('wav\M56-3.wav'); //+14



    g_SoundList.Add('wav\cboZs1_start_m.wav'); //+15
    g_SoundList.Add('wav\cboZs1_start_w.wav'); //+16
    g_SoundList.Add('wav\cboZs2_start.wav'); //+17
    g_SoundList.Add('wav\cboZs3_start_m.wav'); //+18
    g_SoundList.Add('wav\cboZs3_start_w.wav'); //+19
    g_SoundList.Add('wav\cboZs4_start.wav'); //+20

    g_SoundList.Add('wav\cboFs1_start.wav'); //+21
    g_SoundList.Add('wav\cboFs1_target.wav'); //+22
    g_SoundList.Add('wav\cboFs2_start.wav'); //+23
    g_SoundList.Add('wav\cboFs2_target.wav'); //+24
    g_SoundList.Add('wav\cboFs3_start.wav'); //+25
    g_SoundList.Add('wav\cboFs3_target.wav'); //+26
    g_SoundList.Add('wav\cboFs4_start.wav'); //+27
    g_SoundList.Add('wav\cboFs4_target.wav'); //+28

    g_SoundList.Add('wav\cboDs1_start.wav'); //+29
    g_SoundList.Add('wav\cboDs1_target.wav'); //+30
    g_SoundList.Add('wav\cboDs2_start.wav'); //+31
    g_SoundList.Add('wav\cboDs2_target.wav'); //+32
    g_SoundList.Add('wav\cboDs3_start.wav'); //+33
    g_SoundList.Add('wav\cboDs3_target.wav'); //+34
    g_SoundList.Add('wav\cboDs4_start.wav'); //+35
    g_SoundList.Add('wav\cboDs4_target.wav'); //+36



    s_FireFlower_1 := g_nNewsound;
    s_FireFlower_2 := g_nNewsound + 1;
    s_FireFlower_3 := g_nNewsound + 2;
    s_HeroLogIn := g_nNewsound + 3;
    s_HeroLogOut := g_nNewsound + 4;
    s_Openbox := g_nNewsound + 8;

    s_SelectBoxFlash := g_nNewsound + 9;
    s_Flashbox := g_nNewsound + 10;
    s_hero_shield := g_nNewsound + 11;

    s_powerup := g_nNewsound + 12;


    s_hit_ZRJF_M := g_nNewsound + 13;
    s_hit_ZRJF_w := g_nNewsound + 14;


    s_cboZs1_start_m := g_nNewsound + 15;
    s_cboZs1_start_w := g_nNewsound + 16;
    s_cboZs2_start := g_nNewsound + 17;
    s_cboZs3_start_m := g_nNewsound + 18;
    s_cboZs3_start_w := g_nNewsound + 19;
    s_cboZs4_start := g_nNewsound + 20;


    s_cboFs1_start := g_nNewsound + 21;
    s_cboFs1_target := g_nNewsound + 22;

    s_cboFs2_start := g_nNewsound + 23;
    s_cboFs2_target := g_nNewsound + 24;

    s_cboFs3_start := g_nNewsound + 25;
    s_cboFs3_target := g_nNewsound + 26;

    s_cboFs4_start := g_nNewsound + 27;
    s_cboFs4_target := g_nNewsound + 28;

    s_cboDs1_start := g_nNewsound + 29;
    s_cboDs1_target := g_nNewsound + 30;

    s_cboDs2_start := g_nNewsound + 31;
    s_cboDs2_target := g_nNewsound + 32;

    s_cboDs3_start := g_nNewsound + 33;
    s_cboDs3_target := g_nNewsound + 34;

    s_cboDs4_start := g_nNewsound + 35;
    s_cboDs4_target := g_nNewsound + 36;


    //g_SoundList.SaveToFile('SoundList.txt');
    //for I:=0 to g_SoundList.Count - 1 do begin
    //  DebugOutStr(IntToStr(I) +' '+ g_SoundList.Strings[I]);
    //end;
    //DebugOutStr('g_SoundList '+IntToStr(g_SoundList.Count));
  end;
end;

procedure PlaySound(idx: Integer);
begin
  if g_boSound then begin
    if (idx >= 0) and (idx < g_SoundList.Count) then begin
      if g_SoundList[idx] <> '' then
        SoundEngine.PlaySound(g_SoundList[idx]);
        {if FileExists(g_SoundList[idx]) then begin
          try
            if g_Sound.EffectCount < 100 then begin
              g_Sound.EffectFile(g_SoundList[idx], FALSE, FALSE);
            end;
          except
          end;
        end; }
    end;
  end;
end;

procedure PlaySound(const FileName: string);
var
  sFileName, sFileExt: string;
begin
  PlayMp3('', False);
  sFileName := g_sAppFilePath + FileName;
  sFileExt := UpperCase(ExtractFileExt(sFileName));
  if sFileExt = '.MP3' then
    PlayMp3(sFileName, True)
  else
    SoundEngine.PlaySound(sFileName);
end;

procedure PlayMapMusic(boFlag: Boolean);
var
  I: Integer;
  pFileName: ^string;
  sFileName: string;
  nIndex: Integer;
begin
  nIndex := 0;
  sFileName := g_sMapMusic;

  //DebugOutStr('g_sMapMusic: '+g_sMapMusic);
  if boFlag then begin
    if g_sMapMusic <> '' then begin
      if Pos('http://', g_sMapMusic) = 0 then begin
        sFileName := '.\Wav\' + g_sMapMusic;
        nIndex := 2;
      end else nIndex := 1;
    end;
  end else begin
    if Assigned(g_PlugInfo.MediaPlayer.StopPlay) then begin
      g_PlugInfo.MediaPlayer.StopPlay(PChar(sFileName));
    end;
  end;
  if not g_boStartPlay then begin

  end;
  PlayMp3('', False);

  case nIndex of
    1: begin
        if boFlag then begin
          frmMain.PlayMedia(sFileName);
          //SoundEngine.MediaPlayer(sFileName);
         { if Assigned(g_PlugInfo.MediaPlayer.Player) then begin
            g_PlugInfo.MediaPlayer.Player(PChar(sFileName), False, True);
          end; }
        end;
      end;
    2: begin
        PlayMp3(sFileName, boFlag);
      end;
  end;
end;

procedure LoadBGMusicList(flname: string);
var
  strlist: TStringList;
  Str, sMapName, sFileName: string;
  pFileName: ^string;
  I: Integer;
begin
  if FileExists(flname) then begin
    strlist := TStringList.Create;
    strlist.LoadFromFile(flname);
    for I := 0 to strlist.Count - 1 do begin
      Str := strlist[I];
      if (Str = '') or (Str[1] = ';') then Continue;
      Str := GetValidStr3(Str, sMapName, [':', ' ', #9]);
      Str := GetValidStr3(Str, sFileName, [':', ' ', #9]);
      sMapName := Trim(sMapName);
      sFileName := Trim(sFileName);

      if (sMapName <> '') and (sFileName <> '') then begin
        New(pFileName);
        pFileName^ := sFileName;
        BGMusicList.AddObject(sMapName, TObject(pFileName));
      end;
    end;
    strlist.Free; ;
  end;
end;

function PlayBGM(wavname: string): TDirectSoundBuffer;
begin
  Result := nil; //Jacky
  if not g_boBGSound then begin
    SilenceSound;
    Exit;
  end;
  if wavname <> '' then
    if FileExists(wavname) then begin
      try
        SilenceSound;

        SoundEngine.PlayBGM(wavname);
      except
      end;
    end;
end;

procedure PlayMp3(wavname: string; boFlag: Boolean);
begin
  if SoundEngine.m_MP3 <> nil then begin
    if not boFlag then begin
      SoundEngine.m_MP3.stop;
      Exit;
    end;
    if not g_boBGSound then Exit;
    SoundEngine.PlayMp3(wavname);
  end;
end;

procedure SilenceSound;
begin
  SoundEngine.Clear;
end;

procedure ItemClickSound(std: TStdItem);
begin
  case std.StdMode of
    0, 31: PlaySound(s_click_drug);
    5, 6: PlaySound(s_click_weapon);
    10, 11: PlaySound(s_click_armor);
    22, 23: PlaySound(s_click_ring);
    24, 26: begin
        if (Pos('ÊÖïí', std.Name) > 0) or (Pos('ÊÖÌ×', std.Name) > 0) then
          PlaySound(s_click_grobes)
        else
          PlaySound(s_click_armring);
      end;
    19, 20, 21: PlaySound(s_click_necklace);
    15: PlaySound(s_click_helmet);
  else PlaySound(s_itmclick);
  end;
end;

procedure ItemUseSound(StdMode: Integer);
begin
  case StdMode of
    0: PlaySound(s_click_drug);
    1, 2: PlaySound(s_eat_drug);
  else ;
  end;
end;


end.

