abstract class RemoteTourEvent {
  const RemoteTourEvent();
}

class GetTours extends RemoteTourEvent {
  const GetTours();
}
class GetToursWithTag extends RemoteTourEvent {
  const GetToursWithTag();
}
