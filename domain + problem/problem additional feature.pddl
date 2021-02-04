;MISSION 5 - COLLECT FOSSILS IF FOUND, STUDY IT, AND BRING BACK THE REPORT
;IF VORTEX IS PRESENT, BRING THE VORTEX SCAN REPORT ALSO
; 
(define (problem cwproblem5)
  (:domain cw1)

  (:objects
      ca - captain
      na - navigator
      sub - submarine
      br - bridge
      uw - underWaterRegion
      abyssal - region
      vo - vortex
      sciOff fosSciOff - scienceOfficer
      scLab - sciLab
      opLaunchEng opMsEng - engineer
      mac - machine
      se - security
      min - mineral
      lBay - launchBay
      siBay - sickBay
      brep - baseReport
      srep - sensorReport
      expMS - expMiniSub
      sn - sensorNet
      base - baseUW
      leader - baseLeader
      atl - atlanteans 
      rob - robot
      port - seaPort
      portSys - portSystem
      fo - fossil
      fd - fossilDetector
      st - storage
      frep - fossilReport
      drillMS - drillMiniSub
      vrep - vortexReport
      mrep - mineralReport
  )

  (:init
    
      (onBridge ca br)                              ;Captain and Navigator are prsent on the bridge
      (onBridge na br)
    
     
     (order ca na abyssal)                            ;captain orders the navigator to travel to ridge
      
      (contains uw abyssal)                           ;the underwater region contains the ridge

      (onLaunchBay opLaunchEng lBay)                  ;opLauncheng is an engineer who is present on the launch bay and helps in launching the explore minisub
      (onLaunchBay opMsEng lBay)                      ;opMsEng is an engineer who operates the minisub
      (onLaunchBayMS expMS lBay)                      ;explore minisub is present on the launch bay
      
      (operateLaunch opLaunchEng)
 
      (fossilDetected fo fd)                          ;the detector has detected for fossils
        
  
      ;a personnel can travel from launch bay to sick bay and vice versa
      (adjacent lBay siBay)
      (adjacent siBay lBay)
      
      ;a personnel can travel from bridge to launch bay and vice versa
      (adjacent br lBay)
      (adjacent lBay br)
      
      ;a personnel can travel from science lab to sick bay and vice versa
      (adjacent scLab siBay)
      (adjacent siBay scLab)
    
      ;(robPresentIn rob siBay) 

      (at sciOff lBay)            ;science officer collects the minerals from launch bay

      (presentInSubSection fosSciOff scLab)         ;fossil science officer is present in the science lab
      
        
  )

  (:goal
      (and
          
        (collectFossils fo)
        (generateReport mac frep)
      
       (atPortSystem frep portSys)
      )
  )
)