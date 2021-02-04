;MISSION 4 - DRILL FOR MINERALS, STUDY IT AND BRING BACK THE REPORT
;IF VORTEX IS PRESENT, BRING THE VORTEX SCAN REPORT ALSO
;SCENARIO - VORTEX PRSENT IN UNDERWATER REGION (NOT RIDGE) 
(define (problem cwproblem4)
  (:domain cw1)

  (:objects
      ca - captain
      na - navigator
      sub - submarine
      br - bridge
      uw1 uw2 - underWaterRegion
      ridge - region
      vo - vortex
      sciOff vorSciOff - scienceOfficer
      scLab - sciLab
      opLaunchEng opMsEng vorEng - engineer
      mac - machine
      se - security
      min - mineral
      lBay - launchBay
      siBay - sickBay
      vrep - vortexReport
      mrep - mineralReport
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
       brep - baseReport
      srep - sensorReport
      drillMS - drillMiniSub
  )

  (:init
    
      (onBridge ca br)                                    ;Captain and Navigator are prsent on the bridge
      (onBridge na br)
     
     (order ca na ridge)                                  ;captain orders the navigator to travel to ridge
       
      (containsVortex uw1 vo)                              ;uw1 contains the vortex
      
      (presentInSubSection vorSciOff scLab)                ;vortex science officer is present in the science lab

      (orderV ca na vo)                                       ;captain orders the navigator to enter the vortex
    
      (activatedPressureShields vorEng)                     ;pressure shields are up by the engineer
        
  )

  (:goal
      (and
          
        ;(drill min)                                        ;the goal simplifies to false since uw1 doesnt contain a ridge instead contains a vortex
        ;(generateReport mac mrep) 

        (location sub uw2)
        (generateReport mac vrep)
      
       ;(atPortSystem mrep portSys)
       (atPortSystem vrep portSys)
      )
  )
)