
live_loop :bass do
    sync :metro
    if get(:bass_on)
        use_synth :fm
        get(:bassPattern).each do |s| 
            play get(:notesBass).tick(:tickBass), release: 0.3, amp: rrand(get(:minBassAmp),get(:maxBassAmp)) 
            sleep s
        end
        if get(:instrument2_on)
            sleep get(:trumpetPattern).sum #to instruments interspersed.
        elsif get(:instrument3_on)
            sleep get(:fakeVoicePattern).sum #to instruments interspersed. 
        end
    end
end

live_loop :kick do
    sync :bass
    if get(:kick_on)
        playKickPattern(get(:kickPattern1), get(:kickAmp))
        if get(:instrument2_on)
            playKickPattern(get(:kickPattern2), get(:kickAmp)) #to instruments interspersed
        elsif get(:instrument3_on)
            playKickPattern(get(:kickPattern3), get(:kickAmp)) #to instruments interspersed
        end
    end
end

live_loop :trumpet do
    sync :bass
    if get(:trumpet_on)
        use_synth :fm
        if get(:instrument2_on)
            sleep get(:bassPattern).sum #to instruments interspersed
        end
        get(:trumpetPattern).each do |s| 
            play get(:notesTrumpet).tick(:tickTrumpet), release: 0.25, amp: rrand(get(:minTrumpetAmp),get(:maxTrumpetAmp)), cutoff: rrand(100,105), res: 0.9
            sleep s
        end
        if get(:instrument3_on)
            sleep get(:fakeVoicePattern).sum #to instruments interspersed
        end
    end
end

live_loop :freshInternalSamples do
    sync :metro
    if get(:freshInternalSamples_on)
        sample get(:nickNameFIS), amp: get(:FISAmp)
        sleep get(:FISleep)
    end
end

live_loop :lyricSamples do
    sync :bass
    if get(:lyricSamples_on)
        fx_lyricSample do
            playLyricSamples(get(:verseNumber), get(:lyricSamplesPattern), get(:minLyricSamplesAmp), get(:maxLyricSamplesAmp))
        end
    end
end

live_loop :fakeVoice do
    sync :bass
    if get(:fakeVoice_on)
        use_synth :prophet
        if get(:instrument2_on)
            sleep get(:bassPattern).sum #to instruments interspersed
        elsif get(:instrument3_on)
            sleep get(:trumpetPattern).sum #to instruments interspersed
        end
        get(:fakeVoicePattern).each do |s|
            play get(:notesVoice).tick(:tickFakeVoice), attack: 0.1, sustain: 0.4, release: 0.6, cutoff: 90, res: 0.7, amp: rrand(get(:minFakeVoiceAmp), get(:maxFakeVoiceAmp))
            sleep s
        end
    end
end

live_loop :piano do
    sync :bass
    if get(:piano_on)
        use_synth :piano
        get(:pianoPattern).each do |s|
            play get(:notesPiano).tick(:tickPiano), release: 0.3, amp: rrand(get(:minPianoAmp), get(:maxPianoAmp))
            sleep s
        end
    end
end

live_loop :blade do
    sync :bass
    if get(:blade_on)
        use_synth :blade
        with_fx :reverb, mix: 0.5, room: 0.8 do
            get(:bladePattern).each do |s|
                play get(:notesBlade).tick(:tickBlade),  release: 1.5, amp: get(:bladeAmp)
                sleep s
            end
        end
    end
end





