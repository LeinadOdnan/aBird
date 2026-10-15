
live_loop :bass do
    sync :metro
    if get(:bass_on)
        use_synth :fm
        get(:bassPattern).each do |s| 
            play get(:notesBass).tick(:tickBass), release: 0.3, amp: rrand(get(:minBassAmp),get(:maxBassAmp)) 
            sleep s
        end
        #sleep get(:trumpetPattern).sum #to instruments interspersed
    end
end

live_loop :trumpet do
    sync :bass
    if get(:trumpet_on)
        use_synth :fm
        #sleep get(:bassPattern).sum #to instruments interspersed
        get(:trumpetPattern).each do |s| 
            play get(:notesTrumpet).tick(:tickTrumpet), release: 0.25, amp: rrand(get(:minTrumpetAmp),get(:maxTrumpetAmp)), cutoff: rrand(100,105), res: 0.9
            sleep s
        end
    end
end

live_loop :kick do
    sync :bass
    if get(:kick_on)
        playKickPattern(get(:kickPattern1), get(:kickAmp))
        #playKickPattern(get(:kickPattern2), get(:kickAmp)) #to instruments interspersed
    end
end

live_loop :fakeVoice do
    sync :bass
    if get(:fakeVoice_on)
        use_synth :prophet
        #sleep get(:bassPattern).sum #to instruments interspersed
        get(:fakeVoicePattern).each do |s|
            play get(:notesVoice).tick(:tickFakeVoice), attack: 0.1, sustain: 0.4, release: 0.6, cutoff: 90, res: 0.7, amp: rrand(get(:minFakeVoiceAmp), get(:maxFakeVoiceAmp))
            sleep s
        end
    end
end

#miss piano and blade, lyric and fresh samples.
