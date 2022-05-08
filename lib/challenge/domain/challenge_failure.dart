abstract class ChallengeFailure {
  const ChallengeFailure();
}

class ChallengeNotFound extends ChallengeFailure {
  const ChallengeNotFound();
}

class StorageFailure extends ChallengeFailure {
  const StorageFailure();
}

class ChallengeInvalidToWrite extends ChallengeFailure {
  const ChallengeInvalidToWrite();
}
