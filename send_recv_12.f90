       program ping
       include 'mpif.h'
    
       integer numtasks, rank, dest, source, count, tag, ierr
       integer stat(MPI_STATUS_SIZE)   ! required variable for receive routines
       character inmsg, outmsg
       integer,parameter:: Asize=99999999
       !real*8  a(100), b(100)
       !real  a(Asize), b(Asize)
       real*8  a(Asize), b(Asize)
       !outmsg = 'x'
       tag = 1
       a = 20.0
       b = 0.0
        
       call MPI_INIT(ierr)
       call MPI_COMM_RANK(MPI_COMM_WORLD, rank, ierr)
       call MPI_COMM_SIZE(MPI_COMM_WORLD, numtasks, ierr)
    
       !print*, Asize, a(1), a(2), b, rank, numtasks
       print*, Asize, rank, numtasks
       ! task 0 sends to task 1 and waits to receive a return message
       if (rank .eq. 0) then
          dest = 1
       print*, Asize, rank
          !source = 1
          !call MPI_SEND(a(1), Asize, MPI_real, dest, tag, MPI_COMM_WORLD, ierr)
          !call MPI_SEND(a(1), Asize, MPI_real, dest, tag, MPI_COMM_WORLD, ierr)
          call MPI_SEND(a(1), Asize, MPI_double_precision, dest, tag, MPI_COMM_WORLD, ierr)
          !call MPI_RECV(inmsg, 1, MPI_CHARACTER, source, tag, MPI_COMM_WORLD, stat, ierr)
    
       print*,  "rank send =", rank
       ! task 1 waits for task 0 message then returns a message
       else if (rank .eq. 1) then
          !dest = 0
          source = 0
       print*, Asize, rank
      !call MPI_RECV(b(1), Asize, MPI_real, source, tag, MPI_COMM_WORLD, stat, err)
      call MPI_RECV(b(1), Asize, MPI_double_precision, source, tag, MPI_COMM_WORLD, stat, err)
 
       print*,  "rank recv =", rank
          !call MPI_SEND(outmsg, 1, MPI_CHARACTER, dest, tag, MPI_COMM_WORLD, err)
       endif
    
       print*,  "rank after send_recv=", rank
       ! query recieve Stat variable and print message details
!       call MPI_GET_COUNT(stat, MPI_DOUBLE_PRECISION, count, ierr)
!       print *, 'Task ',rank,': Received', count, 'char(s) from task', &
!                stat(MPI_SOURCE), 'with tag',stat(MPI_TAG)
    
       call MPI_FINALIZE(ierr)
    
       end
