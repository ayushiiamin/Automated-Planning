;MISSION 2 - MEET LEADERS 
;IF VORTEX IS PRESENT, BRING THE VORTEX SCAN REPORT ALSO
;SCENARIO - BASE IS UNDER ATTACK
(define (problem cwproblem3)
  (:domain cw1)

  (:objects
      ca - captain
      na - navigator
      sub - submarine
      br - bridge
      uw - underWaterRegion     
      abyssal - region
      vo - vortex
      sciOff vorSciOff - scienceOfficer
      scLab - sciLab
      opLaunchEng opMsEng - engineer
      mac - machine
      se - security
      min - mineral
      lBay - launchBay
      siBay - sickBay
      brep - baseReport
      vrep - vortexReport
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
      drillMS - drillMiniSub
      fr - fossilReport
  )

  (:init
    
      (onBridge ca br)                        ;Captain and Navigator are prsent on the bridge
      (onBridge na br)
     ; (travelTo na uw)
     
     (order ca na abyssal)                      ;captain orders the navigator to travel to abyssal
      
      (contains uw abyssal)                        ;the underwater region contains the abyssal

      (onLaunchBay opLaunchEng lBay)                ;opLauncheng is an engineer who is present on the launch bay and helps in launching the explore minisub
      (onLaunchBay opMsEng lBay)                    ;opMsEng is an engineer who operates the minisub
      (onLaunchBayMS expMS lBay)                    ;explore minisub is present on the launch bay
      (operateLaunch opLaunchEng)
 
        (presentInMS ca expMS)                      ;captain is present on the launch bay 
        ;(presentInMS se expMS)
        
        (has abyssal base)                            ;abyssal has a base
        
      (takenOver atl base)                              ;atlanteans have taken over the base
      
      
        
      ;(at ca lBay)
      ;(at se lBay)

      ;a personnel can travel from launch bay to sick bay and vice versa
      (adjacent lBay siBay)
      (adjacent siBay lBay)
      
      ;a personnel can travel from bridge to launch bay and vice versa
      (adjacent br lBay)
      (adjacent lBay br)
      
      ;a personnel can travel from science lab to sick bay and vice versa
      (adjacent scLab siBay)
      (adjacent siBay scLab)
    
      (robPresentIn rob siBay)          ;robot is present in the sickbay

      
        
  )

  (:goal
      (and
          
        ;(meet ca leader)                  ;; <- goal simplifies to false for (meet ca leader) since atlanteans have taken over the base
        (healthy ca)
        (generateReport mac brep)

      
       (atPortSystem brep portSys)

      )
  )
)
