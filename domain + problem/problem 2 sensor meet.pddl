;MISSION 2 - MEET BASE LEADERS AND DEPLOY SENSOR NETS
;IF VORTEX IS PRESENT, BRING THE VORTEX SCAN REPORT ALSO
;
(define (problem cwproblem2)
  (:domain cw1)

  (:objects
      ca - captain
      na - navigator
      sub - submarine
      br - bridge
      uw - underWaterRegion
      abyssal - region
      vo - vortex
      sciOff minSciOff - scienceOfficer
      scLab - sciLab
      opLaunchEng opMsEng - engineer
      mac - machine
      vrep - vortexReport
      se - security

      drillMS - drillMiniSub
    min - mineral
       
    lBay - launchBay
        
    siBay - sickBay
      
    mrep - mineralReport
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
    fr - fossilReport
  )

  (:init
    
      (onBridge ca br)                      ;Captain and Navigator are prsent on the bridge
      (onBridge na br)
     
     (order ca na abyssal)                    ;captain orders the navigator to travel to abyssal
      
      (contains uw abyssal)                   ;the underwater region contains the abyssal

      (onLaunchBay opLaunchEng lBay)            ;opLauncheng is an engineer who is present on the launch bay and helps in launching the explore minisub
      (onLaunchBay opMsEng lBay)                ;opMsEng is an engineer who operates the minisub
      (onLaunchBayMS expMS lBay)                ;explore minisub is present on the launch bay
        ;(onLaunchBayMS expMS2 lBay)
      (operateLaunch opLaunchEng)

        (at ca lBay)                          ;captain and security are present on the launch bay
        (at se lBay)
  
        (presentInMS ca expMS)                  ;captain and security are then present in the explore minisub
        (presentInMS se expMS)
        
        (has abyssal base)                        ;abyssal has a base

      

      ;a personnel can travel from launch bay to sick bay and vice versa
      (adjacent lBay siBay)
      (adjacent siBay lBay)
      
      ;a personnel can travel from bridge to launch bay and vice versa
      (adjacent br lBay)
      (adjacent lBay br)
      
      ;a personnel can travel from science lab to sick bay and vice versa
      (adjacent scLab siBay)
      (adjacent siBay scLab)
    
        
  )

  (:goal
      (and

        (meet ca leader)
        (generateReport mac brep)

            (deploy sn)
            (generateReport mac srep) 
  
        (atPortSystem brep portSys)
        (atPortSystem srep portSys)
      )
  )
)
